{
  "patcher": {
    "fileversion": 1,
    "appversion": {
      "major": 9,
      "minor": 0,
      "revision": 0,
      "architecture": "x64",
      "modernui": 1
    },
    "classnamespace": "box",
    "rect": [
      100,
      100,
      640,
      480
    ],
    "bglocked": 0,
    "openrect": [
      0,
      0,
      0,
      0
    ],
    "openinpresentation": 0,
    "default_fontsize": 12,
    "default_fontface": 0,
    "default_fontname": "Arial",
    "gridonopen": 2,
    "gridsize": [
      15,
      15
    ],
    "gridsnaponopen": 0,
    "objectsnaponopen": 1,
    "statusbarvisible": 2,
    "toolbarvisible": 2,
    "lefttoolbarpinned": 0,
    "toptoolbarpinned": 0,
    "righttoolbarpinned": 0,
    "bottomtoolbarpinned": 0,
    "toolbars_unpinned_last_save": 0,
    "tallnewobj": 0,
    "boxanimatetime": 200,
    "enablehscroll": 1,
    "enablevscroll": 1,
    "devicewidth": 0,
    "title": "maxforge",
    "description": "One object starts the shared local service",
    "digest": "",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "boxes": [
      {
        "box": {
          "id": "obj-sync",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            40,
            40,
            100,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "maxforge"
        }
      },
      {
        "box": {
          "id": "obj-runtime_help",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            40,
            100,
            550,
            100
          ],
          "text": "One maxforge object starts the shared HTTP service.\\nDiscover /v1/tools; use maxforge_help topic runtime for UI control.\\nmaxforge_read_runtime reads without output.\\nmaxforge_send_message sends supported int/float/bang/list/set messages.\\nRead the class support table in the maxforge-live skill; never retry an ambiguous send.",
          "linecount": 5
        }
      }
    ],
    "lines": []
  }
}