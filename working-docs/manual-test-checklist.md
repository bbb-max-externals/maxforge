# Max/HTTP 手動テストチェックリスト

このチェックリストは、CIが通過した後にだけ実行する。ソースレベルのテストでは証明できない挙動を対象とする。プロセスの再起動、ファイル作成、patcherの変更を意図的に行うため、重要なpatchをテスト対象にしてはいけない。

## テスト記録

テスト開始前に、次のブロックをreleaseまたはissueの記録へコピーする。

```text
実施日:
実施者:
commit/tag:
npm maxforge version:
maxforge externalVersion:
Max version:
Agent/HTTP client:
Node/npm versions:
OS/architecture:
Max package/external path:
@config path/project.id:
結果: PASS / FAIL / BLOCKED
失敗内容と証跡へのリンク:
```

各テストでは、必要に応じて対象の`patcherId`、scope、service PID、structure token、revisionを記録する。スクリーンショットはUIやOS security動作の証跡にはなるが、protocol failureの証跡にはならない。protocol failureにはstructured HTTP outputとMax Consoleのテキストを使う。

## Release gate

通常のrelease candidateではmacOSでH01〜H07とH09を実行する。catalog変更はH08/H10、skill変更はH11、native/package/toolchain変更はH09のWindows項目も対象とする。未検証のgateをPASS扱いしない。

### H01 — Native externalの検出と登録

**前提:** Maxとrelease candidateの完全なMax package。npmは任意のCLIにだけ必要。

1. Maxのsearch pathから、開発中のものを含む重複した`maxforge`を削除するか一時的に名前を変える。重複を放置した場合、意図したbinaryをテストした証明にならない。
2. Maxを起動し、installしたpackageから`maxforge.maxhelp`を開く。
3. objectがmissingになっていないこと、Max Consoleに赤色のload、class、attribute、WebSocket、registration errorがないことを確認する。
4. HTTP discoveryとGET /v1/toolsを確認し、`maxforge_status`、続いて`maxforge_list_patches`を呼ぶ。
5. help patchが登録され、`externalVersion`が同梱serviceのexpected versionと一致し、`versionCompatible`が`true`であることを確認する。

**合格条件:** 意図したbinaryがMax errorなしでload・registerされる。

### H02 — 人間による編集後のAgent差分sync

**前提:** 3個以上の接続済みobjectを含む、破棄可能なregistered patch。

1. 対象をsummary detailとfull detailでinspectし、structure tokenを記録する。
2. Max UI上で、managed objectを1個移動し、`button`を1個追加し、既存patch cordを1本つなぎ替える。何を変更したかはAgentへ伝えない。
3. Agentにlive changesのinspect/reviewと変更内容の説明を依頼する。画面ではなくHTTP stateから説明させる。
4. `maxforge_get_live_edit_history`と`maxforge_review_live_changes`のdefault summaryが、move、addition、rewireをevidenceとして説明しつつ、full snapshot/raw changes/完全DSLを返していないことを確認する。正確なbefore/afterが必要な箇所だけ`detail: "full"`で再取得する。
5. 現在の正確なstructure tokenを使い、受け入れるmanaged editsをadoptする。完全DSLではなく`sourceRef`が返ることを確認する。
6. `maxforge_get_working_source`の`detail: "matches"`で必要なsemantic name周辺だけを取得し、`baseSourceRef`とhalf-open line editsでobjectとconnectionをもう1組prepareする。compact responseがoperation count、全破壊操作、replacement、warningを含み、bulk create/connect/rollback planを含まないことを確認する。
7. `maxforge_apply_prepared_change`へreceiptだけを渡す。acknowledgement後に同じreceiptの再利用が拒否されることを確認する。
8. 再度inspectする。3つの人間編集がすべて残り、reviewしたAgent差分だけが追加されていることを確認する。

**即時失敗条件:** Agentがreviewしていない編集を上書きする、windowの見た目に依存する、stale tokenを使う、またはedit-historyの推論を人間の意図として断定する。

### H03 — Top-level patchの作成、保存、close、reopen

**前提:** controller capabilityを持つregistered patchが1個だけ存在し、書き込み可能なtemporary directoryがあること。

1. Max標準の新規patchでFile > Save Asが有効なことを確認する。ウィンドウ名に`saving disabled`が表示される環境では成功系を実行できないため、BLOCKEDとしてユーザーへ報告する。認証状態の変更はユーザーに任せる。
2. 一意な`patcherId`、scope、titleを指定し、`maxforge_create_patch`で新規patchを作成する。
3. そのpatchが、`maxforge`を1個だけ含む独立したtargetとしてregisterされることを確認する。
4. `button`、`counter`、`print`を含む小さなdesired DSLをprepareし、返されたreceiptだけをapplyしてconnectionをinspectionで検証する。
5. まだ存在しないabsolute temporary `.maxpat` pathを指定し、`overwrite: false`で`maxforge_save_patch`を実行する。Maxがrequested pathとclean patchを報告し、ファイルが存在することを確認する。保存ダイアログが開いた場合は失敗とする。
6. patchを再度変更し、同じpathへ`overwrite: false`で保存する。既存destinationとして拒否された直後にinspectが成功し、targetがpending状態に残っていないことを確認する。
7. 同じpathへ`overwrite: true`で保存し、ファイル内容とMaxのdirty flagが更新されることを確認する。
8. `maxforge_close_patch`でcloseし、target listから消えることを確認する。
9. 保存したファイルをMaxから通常の方法で開き直す。すでに`maxforge`を含むため、`maxforge_open_patch`へ渡してはいけない。自動的にregisterされ、期待するgraphとsaved pathを保持していることを確認する。
10. 別途、sync objectを含まないplain `.maxpat`を作る。それを`maxforge_open_patch`で開き、Maxforgeがsync objectを正確に1個だけinjectし、patchをdirtyにし、独立したtargetとしてregisterすることを確認する。

**合格条件:** duplicate sync objectや曖昧なwindow選択を起こさず、target identityとgraphがfile lifecycle全体で維持される。

### H04 — Singleton lifecycleと永続化

1. Max PID、service PID/port、sourceRef、revision、config/project.idを記録する。
2. 複数patchへmaxforgeを1個ずつ作り、異なるpatcherIdで同じserviceを共有することを確認する。
3. agentだけを再起動し、同じserviceとtargetをinspectできることを確認する。
4. 最初のpatch、続いて全テストpatchを閉じてもservice PID/portが変わらないことを確認する。
5. Maxを通常終了し、helper、port、discovery descriptorが消えることを確認する。
6. config有りでMaxと保存済みpatchを開き直し、source/baseline/historyの復元を確認する。
   未使用receiptは復元されない。config無しはMax PID単位で、再起動後のstate復元を保証しない。

### H05 — 完全なpackageの更新と不整合拒否

1. 破棄可能なpackageコピーでnativeと同梱serviceを異なるversionにする。
2. 起動が拒否され、有効なHTTP endpointを公開しないことを確認する。
3. Maxを閉じて整合したpackage全体へ戻し、再起動後のversionCompatibleを確認する。
4. agentのskill/任意CLIはexact version pin無しでschemaを取得できることを確認する。

### H06 — Max error channel

1. 破棄可能な環境で、存在しない絶対@config pathを最初のmaxforgeへ指定する。
2. startup failureが通常postではなくerror severityでMax Consoleへ表示されることを確認する。
3. valid configへ戻し、必要なMax再起動後に登録を確認する。helper失敗時の自動再起動を期待しない。

### H07 — Loopback HTTPの認証境界

1. discoveryは所有者だけが読めることを確認し、tokenをログへ出さない。
2. 正しいBearer tokenのみ成功し、欠落/誤tokenが401になることを確認する。
3. Origin付きリクエスト、不正Hostが403になり、non-loopbackから接続できないことを確認する。
4. LAN公開やfirewall変更はしない。この構成は別マシンからの直接操作をサポートしない。

### H08 — Project externalとabstraction catalog

1. 正確な`ports.mode`/rules、artifact/search pathsを含め、custom externalを1個、abstractionを1個project catalogへ設定する。
2. 最初のmaxforgeにabsolute `@config` pathを指定し、`maxforge_catalog`で両方のentryを確認する。
3. desired DSLを使ってMax上に両方をinstantiateし、実際のinlet/outlet topologyを確認する。
4. catalog metadataを変更し、`maxforge_reload_catalog`を呼ぶ。Max registrationを切断せずdigestが変わることを確認する。
5. declarationを残したまま実際のMax artifactを取り除く。compiler catalogには表示され続ける一方、Maxはruntime load failureを報告することを確認する。

**合格条件:** declaration metadataはcompileを制御し、runtime availabilityは別のMax search-path問題として正しく扱われる。

### H09 — 公開済みnpm packageとdownload可能なMax package

1. clean temporary directoryで、公開済みexact versionのnpm CLIを実行し、validate/compileを確認する。
2. npm bin link経由でmaxforge live services/toolsが動き、サーバーを自分で起動しないことを確認する。
3. 対応するversioned GitHub Releaseから`maxforge-v<version>.zip`をdownloadし、同名の`.sha256`と展開前に一致することを確認する。moving `latest` release/tagやunversioned assetを使ってはいけない。
4. Maxが対応するpackage/search-pathの方法でpackageをinstallする。
5. macOSでは、必要ならdocumented security actionを実施した後、universal externalがloadされることを確認する。Windowsではx64 `.mxe64`がMaxでloadされることを確認する。
6. 同梱help patchを開き、H01のversion-compatible registration checkを繰り返す。

**合格条件:** npm version、native external version、Git tag/release、download artifactが同じsourceを示し、clean installation pathから動作する。

### H10 — Built-in object catalogの一次資料監査

**前提:** 対象バージョンのMaxが`/Applications/Max.app`、または既知の別pathへinstallされていること。

1. Maxの正確なversionと、監査対象の`C74` resources pathを記録する。
2. repository rootで`python3 scripts/audit-object-catalog.py --max-root <C74-resources-path>`を実行する。
3. `errors=0`で終了することを確認する。warningは黙認せず、対象objectのreference、help patch、saved patcherを確認して理由を記録する。
4. 今回追加・変更した全objectをMaxのobject boxでinstantiateし、missing objectにならないことを確認する。
5. port metadataを変更したobjectは、空の引数と代表的な引数の両方で実際のinlet/outlet数と型を確認する。引数依存objectは最低値、通常値、上限付近を含める。
6. `objectfile` mappingしか根拠がない名称をcatalogへ追加していないことを確認する。`s~` / `r~`をsignal objectとして扱わず、`send~` / `receive~`を使う。

**合格条件:** catalog identityはreference、object index、database、またはsaved patcherの一次資料で裏付けられ、変更したport shapeが実際のMaxと一致する。

### H11 — Skillによるpackage setupとMCP skill移行

1. 一時projectへnpx skillsでmaxforge-liveをinstallし、setup referenceが同梱されることを確認する。
2. 許可されたsetupでのみofficial versioned ZIPとchecksumを取得し、旧形式のみのreleaseは拒否する。
3. 複数のpackage候補を無断上書きせず、Maxを閉じて選択したpackage全体をbackup・交換する。
4. 旧maxforge-mcp skillをexact nameで除去し、shared rootとリンクの両方から消えたことを確認する。
   offline maxforgeと新maxforge-live、および他skillは残す。custom copyは確認なしで消さない。
5. Maxでmaxforgeを1個作成し、HTTP schema、patch一覧、versionCompatibleを確認する。
6. 新形式releaseが無い、保存不可、未登録等は個別にBLOCKEDとして報告する。

## Cleanup

- 意図しない変更を保存せず、破棄可能なpatchを閉じる。
- H03で作成したtemporary `.maxpat`を削除する。
- test用configを元へ戻す。userのpatchや他のMax processを停止しない。
- テスト用Maxの通常終了後にhelper/discoveryの消滅を確認する。
- 一時的に名前を変えたexternalを元へ戻す。ただしMax search pathにactiveなduplicate copyを残してはいけない。
