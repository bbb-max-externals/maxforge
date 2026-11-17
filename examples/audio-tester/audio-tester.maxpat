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
      1200,
      600
    ],
    "bglocked": 1,
    "openrect": [
      0,
      0,
      0,
      0
    ],
    "openinpresentation": 1,
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
    "title": "16ch outputs",
    "description": "White / pink / sine source and sixteen output trims",
    "digest": "",
    "tags": "",
    "style": "",
    "subpatcher_template": "",
    "assistshowspatchername": 0,
    "bgcolor": [
      0.025,
      0.025,
      0.03,
      1
    ],
    "editing_bgcolor": [
      0.025,
      0.025,
      0.03,
      1
    ],
    "locked_bgcolor": [
      0.025,
      0.025,
      0.03,
      1
    ],
    "boxes": [
      {
        "box": {
          "id": "obj-source_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            24,
            20,
            150,
            20
          ],
          "text": "SOURCE",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            24,
            20,
            150,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-source_menu",
          "maxclass": "umenu",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            24,
            48,
            130,
            24
          ],
          "outlettype": [
            "int",
            "",
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "items": [
            "white",
            ",",
            "pink",
            ",",
            "sin"
          ],
          "presentation_rect": [
            24,
            48,
            130,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-source_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            24,
            90,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 1"
        }
      },
      {
        "box": {
          "id": "obj-source_index",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            24,
            125,
            80,
            22
          ],
          "outlettype": [
            "int"
          ],
          "text": "+ 1"
        }
      },
      {
        "box": {
          "id": "obj-white_noise",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            160,
            125,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "noise~"
        }
      },
      {
        "box": {
          "id": "obj-pink_noise",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            240,
            125,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "pink~"
        }
      },
      {
        "box": {
          "id": "obj-sine_frequency_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            340,
            20,
            100,
            20
          ],
          "text": "SIN Hz",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            180,
            20,
            100,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-sine_frequency",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            340,
            48,
            100,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": 20,
          "maximum": 20000,
          "presentation_rect": [
            180,
            48,
            100,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-sine_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            340,
            90,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 1000"
        }
      },
      {
        "box": {
          "id": "obj-sine_frequency_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            340,
            125,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-sine_frequency_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            340,
            160,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 1000"
        }
      },
      {
        "box": {
          "id": "obj-sine_oscillator",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            340,
            195,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "cycle~ 1000"
        }
      },
      {
        "box": {
          "id": "obj-source_select",
          "maxclass": "newobj",
          "numinlets": 4,
          "numoutlets": 1,
          "patching_rect": [
            160,
            240,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "selector~ 3 2"
        }
      },
      {
        "box": {
          "id": "obj-source_gain_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            500,
            20,
            120,
            20
          ],
          "text": "SOURCE dB",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            310,
            20,
            120,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-source_gain_db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            500,
            48,
            100,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "presentation_rect": [
            310,
            48,
            100,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-source_gain_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            500,
            90,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -20."
        }
      },
      {
        "box": {
          "id": "obj-source_gain_linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            500,
            125,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-source_gain_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            500,
            160,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-source_gain_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            500,
            195,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-source_level",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            160,
            285,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-output_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            830,
            20,
            100,
            20
          ],
          "text": "OUTPUT",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            450,
            20,
            100,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-output_enabled",
          "maxclass": "toggle",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            830,
            48,
            24,
            24
          ],
          "outlettype": [
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            450,
            48,
            24,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-output_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            830,
            90,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-output_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            830,
            125,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-output_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            830,
            160,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-output_bus",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            160,
            330,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-source_meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            250,
            330,
            120,
            18
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            500,
            50,
            150,
            18
          ]
        }
      },
      {
        "box": {
          "id": "obj-audio_settings",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            960,
            48,
            115,
            24
          ],
          "outlettype": [
            ""
          ],
          "text": "Audio settings",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "presentation_rect": [
            690,
            48,
            115,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-audio_settings_bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            960,
            90,
            80,
            22
          ],
          "outlettype": [
            "bang"
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "obj-audio_settings_message",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            960,
            125,
            100,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "; dsp status"
        }
      },
      {
        "box": {
          "id": "obj-dsp_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            1100,
            20,
            60,
            20
          ],
          "text": "DSP",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            840,
            20,
            60,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-dsp_switch",
          "maxclass": "ezdac~",
          "numinlets": 2,
          "numoutlets": 0,
          "patching_rect": [
            1100,
            48,
            28,
            28
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            840,
            46,
            28,
            28
          ]
        }
      },
      {
        "box": {
          "id": "obj-all_mute_button",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1180,
            48,
            90,
            24
          ],
          "outlettype": [
            ""
          ],
          "text": "All -inf",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "presentation_rect": [
            920,
            48,
            90,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-all_mute_bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1180,
            90,
            80,
            22
          ],
          "outlettype": [
            "bang"
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "obj-all_mute_value",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1180,
            125,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "-100."
        }
      },
      {
        "box": {
          "id": "obj-all_unity_button",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1300,
            48,
            90,
            24
          ],
          "outlettype": [
            ""
          ],
          "text": "All 0 dB",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "presentation_rect": [
            1030,
            48,
            90,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-all_unity_bang",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1300,
            90,
            80,
            22
          ],
          "outlettype": [
            "bang"
          ],
          "text": "t b"
        }
      },
      {
        "box": {
          "id": "obj-all_unity_value",
          "maxclass": "message",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1300,
            125,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "0."
        }
      },
      {
        "box": {
          "id": "obj-output_channels_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            24,
            390,
            250,
            20
          ],
          "text": "OUTPUT TRIM / dB",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            24,
            110,
            250,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-range_label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            24,
            430,
            700,
            20
          ],
          "text": "-100 = -inf    /    Solo: selected channels only    /    Mute takes priority",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "presentation_rect": [
            24,
            540,
            900,
            20
          ]
        }
      },
      {
        "box": {
          "id": "obj-solo_states",
          "maxclass": "newobj",
          "numinlets": 16,
          "numoutlets": 1,
          "patching_rect": [
            1480,
            48,
            330,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-solo_sum",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1480,
            90,
            80,
            22
          ],
          "outlettype": [
            "",
            ""
          ],
          "text": "zl sum"
        }
      },
      {
        "box": {
          "id": "obj-any_solo",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1480,
            125,
            80,
            22
          ],
          "outlettype": [
            "int"
          ],
          "text": "> 0"
        }
      },
      {
        "box": {
          "id": "obj-output_dac",
          "maxclass": "newobj",
          "numinlets": 16,
          "numoutlets": 0,
          "patching_rect": [
            24,
            1250,
            1100,
            22
          ],
          "text": "dac~ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            24,
            500,
            60,
            22
          ],
          "text": "1",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            24,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_1__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            24,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            30,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_1__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            24,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            24,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_1__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            100,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            100,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_1__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            24,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            24,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            24,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_1__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            24,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_1__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            24,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            24,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_1__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            100,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            24,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_1__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            180,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            24,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            24,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            24,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            24,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            24,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_1__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            145,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_1__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            24,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_1__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            140,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            63,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_2__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            344,
            500,
            60,
            22
          ],
          "text": "2",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            95,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_2__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            344,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            101,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_2__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            344,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            95,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_2__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            420,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_2__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            344,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            344,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            344,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_2__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            344,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_2__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            344,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            95,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_2__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            420,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            95,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_2__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            500,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            344,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            344,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            344,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            344,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            344,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_2__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            465,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_2__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            344,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_2__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            460,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            134,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_3__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            664,
            500,
            60,
            22
          ],
          "text": "3",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            166,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_3__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            664,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            172,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_3__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            664,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            166,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_3__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            740,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            740,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_3__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            664,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            664,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            664,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_3__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            664,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_3__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            664,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            166,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_3__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            740,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            166,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_3__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            820,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            664,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            664,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            664,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            664,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            664,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_3__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            785,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_3__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            664,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_3__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            780,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            205,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_4__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            984,
            500,
            60,
            22
          ],
          "text": "4",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            237,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_4__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            984,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            243,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_4__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            984,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            237,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_4__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1060,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1060,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_4__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            984,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            984,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            984,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_4__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            984,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_4__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            984,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            237,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_4__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1060,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            237,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_4__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1140,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            984,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            984,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            984,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            984,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            984,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_4__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1105,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_4__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            984,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_4__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1100,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            276,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_5__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            1304,
            500,
            60,
            22
          ],
          "text": "5",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            308,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_5__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            314,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_5__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1304,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            308,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_5__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1380,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1380,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_5__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1304,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_5__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_5__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1304,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            308,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_5__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1380,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            308,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_5__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1460,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1304,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1304,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_5__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1425,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_5__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1304,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_5__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1420,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            347,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_6__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            1624,
            500,
            60,
            22
          ],
          "text": "6",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            379,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_6__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            385,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_6__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1624,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            379,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_6__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1700,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1700,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_6__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1624,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_6__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_6__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1624,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            379,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_6__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1700,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            379,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_6__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1780,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1624,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1624,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_6__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1745,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_6__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1624,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_6__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1740,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            418,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_7__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            1944,
            500,
            60,
            22
          ],
          "text": "7",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            450,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_7__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            456,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_7__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1944,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            450,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_7__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2020,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2020,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_7__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            1944,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_7__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_7__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1944,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            450,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_7__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2020,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            450,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_7__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2100,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            1944,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            1944,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_7__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            2065,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_7__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            1944,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_7__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2060,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            489,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_8__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            2264,
            500,
            60,
            22
          ],
          "text": "8",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            521,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_8__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            527,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_8__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            2264,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            521,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_8__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2340,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2340,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_8__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            2264,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_8__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_8__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2264,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            521,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_8__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2340,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            521,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_8__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2420,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            2264,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2264,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_8__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            2385,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_8__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2264,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_8__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2380,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            560,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_9__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            2584,
            500,
            60,
            22
          ],
          "text": "9",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            592,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_9__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            598,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_9__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            2584,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            592,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_9__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2660,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2660,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_9__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            2584,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_9__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_9__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2584,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            592,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_9__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2660,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            592,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_9__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2740,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            2584,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2584,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_9__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            2705,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_9__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2584,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_9__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2700,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            631,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_10__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            2904,
            500,
            60,
            22
          ],
          "text": "10",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            663,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_10__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            669,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_10__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            2904,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            663,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_10__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2980,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2980,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_10__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            2904,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_10__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_10__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2904,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            663,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_10__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2980,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            663,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_10__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3060,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            2904,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            2904,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_10__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3025,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_10__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            2904,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_10__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3020,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            702,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_11__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            3224,
            500,
            60,
            22
          ],
          "text": "11",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            734,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_11__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            740,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_11__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            3224,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            734,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_11__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3300,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3300,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_11__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3224,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_11__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_11__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3224,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            734,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_11__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3300,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            734,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_11__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3380,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            3224,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3224,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_11__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3345,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_11__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3224,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_11__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3340,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            773,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_12__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            3544,
            500,
            60,
            22
          ],
          "text": "12",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            805,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_12__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            811,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_12__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            3544,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            805,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_12__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3620,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3620,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_12__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3544,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_12__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_12__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3544,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            805,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_12__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3620,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            805,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_12__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3700,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            3544,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3544,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_12__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3665,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_12__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3544,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_12__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3660,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            844,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_13__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            3864,
            500,
            60,
            22
          ],
          "text": "13",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            876,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_13__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            882,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_13__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            3864,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            876,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_13__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3940,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3940,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_13__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3864,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_13__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_13__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3864,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            876,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_13__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3940,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            876,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_13__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4020,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            3864,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            3864,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_13__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            3985,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_13__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            3864,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_13__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            3980,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            915,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_14__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            4184,
            500,
            60,
            22
          ],
          "text": "14",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            947,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_14__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            953,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_14__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            4184,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            947,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_14__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4260,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4260,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_14__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            4184,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_14__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_14__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4184,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            947,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_14__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4260,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            947,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_14__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4340,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            4184,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4184,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_14__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            4305,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_14__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4184,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_14__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4300,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            986,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_15__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            4504,
            500,
            60,
            22
          ],
          "text": "15",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            1018,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_15__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            1024,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_15__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            4504,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            1018,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_15__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4580,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4580,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_15__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            4504,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_15__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_15__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4504,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            1018,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_15__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4580,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            1018,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_15__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4660,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            4504,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4504,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_15__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            4625,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_15__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4504,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_15__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4620,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            1057,
            180,
            13,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_16__label",
          "maxclass": "comment",
          "numinlets": 1,
          "numoutlets": 0,
          "patching_rect": [
            4824,
            500,
            60,
            22
          ],
          "text": "16",
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "textcolor": [
            0.65,
            0.67,
            0.7,
            1
          ],
          "textjustification": 1,
          "presentation_rect": [
            1089,
            145,
            61,
            22
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_16__fader",
          "maxclass": "slider",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            540,
            26,
            180
          ],
          "outlettype": [
            ""
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.09,
            0.1,
            0.12,
            1
          ],
          "knobcolor": [
            0.73,
            0.78,
            0.83,
            1
          ],
          "knobshape": 5,
          "floatoutput": 1,
          "min": -100,
          "size": 100,
          "inputrangemode": 1,
          "orientation": 2,
          "presentation_rect": [
            1095,
            180,
            26,
            225
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_16__db",
          "maxclass": "flonum",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            4824,
            750,
            61,
            24
          ],
          "outlettype": [
            "",
            "bang"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "bgcolor": [
            0.075,
            0.08,
            0.09,
            1
          ],
          "textcolor": [
            0.88,
            0.9,
            0.93,
            1
          ],
          "minimum": -100,
          "maximum": 0,
          "format": 6,
          "presentation_rect": [
            1089,
            425,
            61,
            24
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_16__fader_set",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4900,
            750,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "prepend set"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4900,
            710,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess -100."
        }
      },
      {
        "box": {
          "id": "obj-channel_16__linear",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            800,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr ($f1>-100.)*pow(10.,$f1/20.)"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            840,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            4824,
            880,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_16__gain",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            920,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_16__solo",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4824,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.96,
            0.68,
            0.19,
            1
          ],
          "textoncolor": [
            0.06,
            0.06,
            0.07,
            1
          ],
          "mode": 1,
          "text": "Solo",
          "texton": "Solo",
          "presentation_rect": [
            1089,
            463,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_16__mute",
          "maxclass": "textbutton",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4900,
            965,
            61,
            25
          ],
          "outlettype": [
            "",
            "",
            "int"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "rounded": 4,
          "usebgoncolor": 1,
          "usegradient": 0,
          "bgcolor": [
            0.105,
            0.11,
            0.12,
            1
          ],
          "textcolor": [
            0.55,
            0.57,
            0.6,
            1
          ],
          "bgoncolor": [
            0.83,
            0.23,
            0.27,
            1
          ],
          "textoncolor": [
            1,
            1,
            1,
            1
          ],
          "mode": 1,
          "text": "Mute",
          "texton": "Mute",
          "presentation_rect": [
            1089,
            494,
            61,
            25
          ]
        }
      },
      {
        "box": {
          "id": "obj-channel_16__switch_default",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4980,
            965,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "loadmess 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__solo_order",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 2,
          "patching_rect": [
            4824,
            1005,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int"
          ],
          "text": "t i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__gate_state",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            1040,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pak 0 0 0"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__gate_unpack",
          "maxclass": "newobj",
          "numinlets": 1,
          "numoutlets": 3,
          "patching_rect": [
            4824,
            1075,
            80,
            22
          ],
          "outlettype": [
            "int",
            "int",
            "int"
          ],
          "text": "unpack i i i"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__audible",
          "maxclass": "newobj",
          "numinlets": 3,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            1110,
            290,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "expr (($i3==0)||($i1!=0))&&($i2==0)"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__gate_ramp",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            1145,
            80,
            22
          ],
          "outlettype": [
            ""
          ],
          "text": "pack 0. 20"
        }
      },
      {
        "box": {
          "id": "obj-channel_16__gate_signal",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 2,
          "patching_rect": [
            4945,
            1145,
            80,
            22
          ],
          "outlettype": [
            "signal",
            "bang"
          ],
          "text": "line~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_16__gate",
          "maxclass": "newobj",
          "numinlets": 2,
          "numoutlets": 1,
          "patching_rect": [
            4824,
            1190,
            80,
            22
          ],
          "outlettype": [
            "signal"
          ],
          "text": "*~ 0."
        }
      },
      {
        "box": {
          "id": "obj-channel_16__meter",
          "maxclass": "meter~",
          "numinlets": 1,
          "numoutlets": 1,
          "patching_rect": [
            4940,
            920,
            100,
            15
          ],
          "outlettype": [
            "float"
          ],
          "fontname": "Arial",
          "fontsize": 12,
          "presentation": 1,
          "presentation_rect": [
            1128,
            180,
            13,
            225
          ]
        }
      }
    ],
    "lines": [
      {
        "patchline": {
          "source": [
            "obj-solo_states",
            0
          ],
          "destination": [
            "obj-solo_sum",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-solo_sum",
            0
          ],
          "destination": [
            "obj-any_solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_default",
            0
          ],
          "destination": [
            "obj-source_menu",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_menu",
            0
          ],
          "destination": [
            "obj-source_index",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_index",
            0
          ],
          "destination": [
            "obj-source_select",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-white_noise",
            0
          ],
          "destination": [
            "obj-source_select",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-pink_noise",
            0
          ],
          "destination": [
            "obj-source_select",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-sine_default",
            0
          ],
          "destination": [
            "obj-sine_frequency",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-sine_frequency",
            0
          ],
          "destination": [
            "obj-sine_frequency_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-sine_frequency_ramp",
            0
          ],
          "destination": [
            "obj-sine_frequency_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-sine_frequency_signal",
            0
          ],
          "destination": [
            "obj-sine_oscillator",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-sine_oscillator",
            0
          ],
          "destination": [
            "obj-source_select",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_gain_default",
            0
          ],
          "destination": [
            "obj-source_gain_db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_gain_db",
            0
          ],
          "destination": [
            "obj-source_gain_linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_gain_linear",
            0
          ],
          "destination": [
            "obj-source_gain_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_gain_ramp",
            0
          ],
          "destination": [
            "obj-source_gain_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_gain_signal",
            0
          ],
          "destination": [
            "obj-source_level",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_select",
            0
          ],
          "destination": [
            "obj-source_level",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-source_level",
            0
          ],
          "destination": [
            "obj-output_bus",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_default",
            0
          ],
          "destination": [
            "obj-output_enabled",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_enabled",
            0
          ],
          "destination": [
            "obj-output_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_ramp",
            0
          ],
          "destination": [
            "obj-output_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_signal",
            0
          ],
          "destination": [
            "obj-output_bus",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-source_meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-audio_settings",
            0
          ],
          "destination": [
            "obj-audio_settings_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-audio_settings_bang",
            0
          ],
          "destination": [
            "obj-audio_settings_message",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_button",
            0
          ],
          "destination": [
            "obj-all_mute_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_bang",
            0
          ],
          "destination": [
            "obj-all_mute_value",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_button",
            0
          ],
          "destination": [
            "obj-all_unity_bang",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_bang",
            0
          ],
          "destination": [
            "obj-all_unity_value",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__default",
            0
          ],
          "destination": [
            "obj-channel_1__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__fader",
            0
          ],
          "destination": [
            "obj-channel_1__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__db",
            0
          ],
          "destination": [
            "obj-channel_1__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__fader_set",
            0
          ],
          "destination": [
            "obj-channel_1__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__db",
            0
          ],
          "destination": [
            "obj-channel_1__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__linear",
            0
          ],
          "destination": [
            "obj-channel_1__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__ramp",
            0
          ],
          "destination": [
            "obj-channel_1__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__signal",
            0
          ],
          "destination": [
            "obj-channel_1__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gain",
            0
          ],
          "destination": [
            "obj-channel_1__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate",
            0
          ],
          "destination": [
            "obj-channel_1__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__switch_default",
            0
          ],
          "destination": [
            "obj-channel_1__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__switch_default",
            0
          ],
          "destination": [
            "obj-channel_1__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__solo",
            0
          ],
          "destination": [
            "obj-channel_1__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__solo_order",
            1
          ],
          "destination": [
            "obj-channel_1__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__mute",
            0
          ],
          "destination": [
            "obj-channel_1__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate_state",
            0
          ],
          "destination": [
            "obj-channel_1__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_1__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_1__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_1__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__audible",
            0
          ],
          "destination": [
            "obj-channel_1__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_1__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_1__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_1__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_1__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_1__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_1__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_1__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__default",
            0
          ],
          "destination": [
            "obj-channel_2__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__fader",
            0
          ],
          "destination": [
            "obj-channel_2__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__db",
            0
          ],
          "destination": [
            "obj-channel_2__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__fader_set",
            0
          ],
          "destination": [
            "obj-channel_2__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__db",
            0
          ],
          "destination": [
            "obj-channel_2__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__linear",
            0
          ],
          "destination": [
            "obj-channel_2__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__ramp",
            0
          ],
          "destination": [
            "obj-channel_2__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__signal",
            0
          ],
          "destination": [
            "obj-channel_2__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gain",
            0
          ],
          "destination": [
            "obj-channel_2__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate",
            0
          ],
          "destination": [
            "obj-channel_2__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__switch_default",
            0
          ],
          "destination": [
            "obj-channel_2__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__switch_default",
            0
          ],
          "destination": [
            "obj-channel_2__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__solo",
            0
          ],
          "destination": [
            "obj-channel_2__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__solo_order",
            1
          ],
          "destination": [
            "obj-channel_2__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__mute",
            0
          ],
          "destination": [
            "obj-channel_2__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate_state",
            0
          ],
          "destination": [
            "obj-channel_2__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_2__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_2__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_2__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__audible",
            0
          ],
          "destination": [
            "obj-channel_2__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_2__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_2__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_2__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_2__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_2__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_2__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_2__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__default",
            0
          ],
          "destination": [
            "obj-channel_3__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__fader",
            0
          ],
          "destination": [
            "obj-channel_3__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__db",
            0
          ],
          "destination": [
            "obj-channel_3__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__fader_set",
            0
          ],
          "destination": [
            "obj-channel_3__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__db",
            0
          ],
          "destination": [
            "obj-channel_3__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__linear",
            0
          ],
          "destination": [
            "obj-channel_3__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__ramp",
            0
          ],
          "destination": [
            "obj-channel_3__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__signal",
            0
          ],
          "destination": [
            "obj-channel_3__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gain",
            0
          ],
          "destination": [
            "obj-channel_3__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate",
            0
          ],
          "destination": [
            "obj-channel_3__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__switch_default",
            0
          ],
          "destination": [
            "obj-channel_3__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__switch_default",
            0
          ],
          "destination": [
            "obj-channel_3__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__solo",
            0
          ],
          "destination": [
            "obj-channel_3__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__solo_order",
            1
          ],
          "destination": [
            "obj-channel_3__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__mute",
            0
          ],
          "destination": [
            "obj-channel_3__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate_state",
            0
          ],
          "destination": [
            "obj-channel_3__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_3__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_3__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_3__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__audible",
            0
          ],
          "destination": [
            "obj-channel_3__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_3__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_3__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_3__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_3__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_3__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_3__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_3__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__default",
            0
          ],
          "destination": [
            "obj-channel_4__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__fader",
            0
          ],
          "destination": [
            "obj-channel_4__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__db",
            0
          ],
          "destination": [
            "obj-channel_4__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__fader_set",
            0
          ],
          "destination": [
            "obj-channel_4__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__db",
            0
          ],
          "destination": [
            "obj-channel_4__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__linear",
            0
          ],
          "destination": [
            "obj-channel_4__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__ramp",
            0
          ],
          "destination": [
            "obj-channel_4__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__signal",
            0
          ],
          "destination": [
            "obj-channel_4__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gain",
            0
          ],
          "destination": [
            "obj-channel_4__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate",
            0
          ],
          "destination": [
            "obj-channel_4__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__switch_default",
            0
          ],
          "destination": [
            "obj-channel_4__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__switch_default",
            0
          ],
          "destination": [
            "obj-channel_4__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__solo",
            0
          ],
          "destination": [
            "obj-channel_4__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__solo_order",
            1
          ],
          "destination": [
            "obj-channel_4__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__mute",
            0
          ],
          "destination": [
            "obj-channel_4__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate_state",
            0
          ],
          "destination": [
            "obj-channel_4__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_4__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_4__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_4__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__audible",
            0
          ],
          "destination": [
            "obj-channel_4__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_4__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_4__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_4__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_4__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            3
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_4__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_4__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_4__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__default",
            0
          ],
          "destination": [
            "obj-channel_5__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__fader",
            0
          ],
          "destination": [
            "obj-channel_5__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__db",
            0
          ],
          "destination": [
            "obj-channel_5__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__fader_set",
            0
          ],
          "destination": [
            "obj-channel_5__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__db",
            0
          ],
          "destination": [
            "obj-channel_5__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__linear",
            0
          ],
          "destination": [
            "obj-channel_5__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__ramp",
            0
          ],
          "destination": [
            "obj-channel_5__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__signal",
            0
          ],
          "destination": [
            "obj-channel_5__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gain",
            0
          ],
          "destination": [
            "obj-channel_5__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate",
            0
          ],
          "destination": [
            "obj-channel_5__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__switch_default",
            0
          ],
          "destination": [
            "obj-channel_5__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__switch_default",
            0
          ],
          "destination": [
            "obj-channel_5__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__solo",
            0
          ],
          "destination": [
            "obj-channel_5__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__solo_order",
            1
          ],
          "destination": [
            "obj-channel_5__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__mute",
            0
          ],
          "destination": [
            "obj-channel_5__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate_state",
            0
          ],
          "destination": [
            "obj-channel_5__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_5__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_5__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_5__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__audible",
            0
          ],
          "destination": [
            "obj-channel_5__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_5__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_5__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_5__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            4
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_5__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            4
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_5__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_5__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_5__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__default",
            0
          ],
          "destination": [
            "obj-channel_6__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__fader",
            0
          ],
          "destination": [
            "obj-channel_6__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__db",
            0
          ],
          "destination": [
            "obj-channel_6__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__fader_set",
            0
          ],
          "destination": [
            "obj-channel_6__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__db",
            0
          ],
          "destination": [
            "obj-channel_6__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__linear",
            0
          ],
          "destination": [
            "obj-channel_6__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__ramp",
            0
          ],
          "destination": [
            "obj-channel_6__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__signal",
            0
          ],
          "destination": [
            "obj-channel_6__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gain",
            0
          ],
          "destination": [
            "obj-channel_6__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate",
            0
          ],
          "destination": [
            "obj-channel_6__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__switch_default",
            0
          ],
          "destination": [
            "obj-channel_6__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__switch_default",
            0
          ],
          "destination": [
            "obj-channel_6__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__solo",
            0
          ],
          "destination": [
            "obj-channel_6__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__solo_order",
            1
          ],
          "destination": [
            "obj-channel_6__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__mute",
            0
          ],
          "destination": [
            "obj-channel_6__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate_state",
            0
          ],
          "destination": [
            "obj-channel_6__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_6__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_6__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_6__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__audible",
            0
          ],
          "destination": [
            "obj-channel_6__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_6__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_6__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_6__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_6__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            5
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_6__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_6__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_6__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__default",
            0
          ],
          "destination": [
            "obj-channel_7__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__fader",
            0
          ],
          "destination": [
            "obj-channel_7__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__db",
            0
          ],
          "destination": [
            "obj-channel_7__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__fader_set",
            0
          ],
          "destination": [
            "obj-channel_7__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__db",
            0
          ],
          "destination": [
            "obj-channel_7__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__linear",
            0
          ],
          "destination": [
            "obj-channel_7__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__ramp",
            0
          ],
          "destination": [
            "obj-channel_7__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__signal",
            0
          ],
          "destination": [
            "obj-channel_7__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gain",
            0
          ],
          "destination": [
            "obj-channel_7__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate",
            0
          ],
          "destination": [
            "obj-channel_7__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__switch_default",
            0
          ],
          "destination": [
            "obj-channel_7__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__switch_default",
            0
          ],
          "destination": [
            "obj-channel_7__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__solo",
            0
          ],
          "destination": [
            "obj-channel_7__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__solo_order",
            1
          ],
          "destination": [
            "obj-channel_7__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__mute",
            0
          ],
          "destination": [
            "obj-channel_7__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate_state",
            0
          ],
          "destination": [
            "obj-channel_7__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_7__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_7__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_7__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__audible",
            0
          ],
          "destination": [
            "obj-channel_7__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_7__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_7__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_7__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            6
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_7__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            6
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_7__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_7__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_7__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__default",
            0
          ],
          "destination": [
            "obj-channel_8__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__fader",
            0
          ],
          "destination": [
            "obj-channel_8__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__db",
            0
          ],
          "destination": [
            "obj-channel_8__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__fader_set",
            0
          ],
          "destination": [
            "obj-channel_8__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__db",
            0
          ],
          "destination": [
            "obj-channel_8__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__linear",
            0
          ],
          "destination": [
            "obj-channel_8__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__ramp",
            0
          ],
          "destination": [
            "obj-channel_8__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__signal",
            0
          ],
          "destination": [
            "obj-channel_8__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gain",
            0
          ],
          "destination": [
            "obj-channel_8__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate",
            0
          ],
          "destination": [
            "obj-channel_8__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__switch_default",
            0
          ],
          "destination": [
            "obj-channel_8__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__switch_default",
            0
          ],
          "destination": [
            "obj-channel_8__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__solo",
            0
          ],
          "destination": [
            "obj-channel_8__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__solo_order",
            1
          ],
          "destination": [
            "obj-channel_8__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__mute",
            0
          ],
          "destination": [
            "obj-channel_8__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate_state",
            0
          ],
          "destination": [
            "obj-channel_8__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_8__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_8__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_8__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__audible",
            0
          ],
          "destination": [
            "obj-channel_8__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_8__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_8__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_8__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            7
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_8__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            7
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_8__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_8__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_8__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__default",
            0
          ],
          "destination": [
            "obj-channel_9__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__fader",
            0
          ],
          "destination": [
            "obj-channel_9__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__db",
            0
          ],
          "destination": [
            "obj-channel_9__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__fader_set",
            0
          ],
          "destination": [
            "obj-channel_9__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__db",
            0
          ],
          "destination": [
            "obj-channel_9__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__linear",
            0
          ],
          "destination": [
            "obj-channel_9__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__ramp",
            0
          ],
          "destination": [
            "obj-channel_9__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__signal",
            0
          ],
          "destination": [
            "obj-channel_9__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gain",
            0
          ],
          "destination": [
            "obj-channel_9__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate",
            0
          ],
          "destination": [
            "obj-channel_9__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__switch_default",
            0
          ],
          "destination": [
            "obj-channel_9__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__switch_default",
            0
          ],
          "destination": [
            "obj-channel_9__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__solo",
            0
          ],
          "destination": [
            "obj-channel_9__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__solo_order",
            1
          ],
          "destination": [
            "obj-channel_9__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__mute",
            0
          ],
          "destination": [
            "obj-channel_9__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate_state",
            0
          ],
          "destination": [
            "obj-channel_9__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_9__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_9__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_9__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__audible",
            0
          ],
          "destination": [
            "obj-channel_9__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_9__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_9__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_9__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            8
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_9__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            8
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_9__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_9__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_9__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__default",
            0
          ],
          "destination": [
            "obj-channel_10__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__fader",
            0
          ],
          "destination": [
            "obj-channel_10__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__db",
            0
          ],
          "destination": [
            "obj-channel_10__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__fader_set",
            0
          ],
          "destination": [
            "obj-channel_10__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__db",
            0
          ],
          "destination": [
            "obj-channel_10__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__linear",
            0
          ],
          "destination": [
            "obj-channel_10__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__ramp",
            0
          ],
          "destination": [
            "obj-channel_10__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__signal",
            0
          ],
          "destination": [
            "obj-channel_10__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gain",
            0
          ],
          "destination": [
            "obj-channel_10__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate",
            0
          ],
          "destination": [
            "obj-channel_10__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__switch_default",
            0
          ],
          "destination": [
            "obj-channel_10__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__switch_default",
            0
          ],
          "destination": [
            "obj-channel_10__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__solo",
            0
          ],
          "destination": [
            "obj-channel_10__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__solo_order",
            1
          ],
          "destination": [
            "obj-channel_10__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__mute",
            0
          ],
          "destination": [
            "obj-channel_10__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate_state",
            0
          ],
          "destination": [
            "obj-channel_10__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_10__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_10__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_10__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__audible",
            0
          ],
          "destination": [
            "obj-channel_10__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_10__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_10__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_10__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            9
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_10__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            9
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_10__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_10__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_10__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__default",
            0
          ],
          "destination": [
            "obj-channel_11__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__fader",
            0
          ],
          "destination": [
            "obj-channel_11__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__db",
            0
          ],
          "destination": [
            "obj-channel_11__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__fader_set",
            0
          ],
          "destination": [
            "obj-channel_11__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__db",
            0
          ],
          "destination": [
            "obj-channel_11__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__linear",
            0
          ],
          "destination": [
            "obj-channel_11__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__ramp",
            0
          ],
          "destination": [
            "obj-channel_11__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__signal",
            0
          ],
          "destination": [
            "obj-channel_11__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gain",
            0
          ],
          "destination": [
            "obj-channel_11__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate",
            0
          ],
          "destination": [
            "obj-channel_11__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__switch_default",
            0
          ],
          "destination": [
            "obj-channel_11__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__switch_default",
            0
          ],
          "destination": [
            "obj-channel_11__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__solo",
            0
          ],
          "destination": [
            "obj-channel_11__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__solo_order",
            1
          ],
          "destination": [
            "obj-channel_11__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__mute",
            0
          ],
          "destination": [
            "obj-channel_11__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate_state",
            0
          ],
          "destination": [
            "obj-channel_11__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_11__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_11__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_11__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__audible",
            0
          ],
          "destination": [
            "obj-channel_11__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_11__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_11__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_11__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            10
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_11__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            10
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_11__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_11__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_11__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__default",
            0
          ],
          "destination": [
            "obj-channel_12__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__fader",
            0
          ],
          "destination": [
            "obj-channel_12__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__db",
            0
          ],
          "destination": [
            "obj-channel_12__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__fader_set",
            0
          ],
          "destination": [
            "obj-channel_12__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__db",
            0
          ],
          "destination": [
            "obj-channel_12__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__linear",
            0
          ],
          "destination": [
            "obj-channel_12__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__ramp",
            0
          ],
          "destination": [
            "obj-channel_12__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__signal",
            0
          ],
          "destination": [
            "obj-channel_12__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gain",
            0
          ],
          "destination": [
            "obj-channel_12__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate",
            0
          ],
          "destination": [
            "obj-channel_12__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__switch_default",
            0
          ],
          "destination": [
            "obj-channel_12__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__switch_default",
            0
          ],
          "destination": [
            "obj-channel_12__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__solo",
            0
          ],
          "destination": [
            "obj-channel_12__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__solo_order",
            1
          ],
          "destination": [
            "obj-channel_12__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__mute",
            0
          ],
          "destination": [
            "obj-channel_12__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate_state",
            0
          ],
          "destination": [
            "obj-channel_12__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_12__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_12__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_12__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__audible",
            0
          ],
          "destination": [
            "obj-channel_12__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_12__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_12__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_12__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            11
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_12__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            11
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_12__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_12__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_12__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__default",
            0
          ],
          "destination": [
            "obj-channel_13__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__fader",
            0
          ],
          "destination": [
            "obj-channel_13__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__db",
            0
          ],
          "destination": [
            "obj-channel_13__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__fader_set",
            0
          ],
          "destination": [
            "obj-channel_13__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__db",
            0
          ],
          "destination": [
            "obj-channel_13__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__linear",
            0
          ],
          "destination": [
            "obj-channel_13__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__ramp",
            0
          ],
          "destination": [
            "obj-channel_13__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__signal",
            0
          ],
          "destination": [
            "obj-channel_13__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gain",
            0
          ],
          "destination": [
            "obj-channel_13__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate",
            0
          ],
          "destination": [
            "obj-channel_13__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__switch_default",
            0
          ],
          "destination": [
            "obj-channel_13__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__switch_default",
            0
          ],
          "destination": [
            "obj-channel_13__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__solo",
            0
          ],
          "destination": [
            "obj-channel_13__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__solo_order",
            1
          ],
          "destination": [
            "obj-channel_13__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__mute",
            0
          ],
          "destination": [
            "obj-channel_13__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate_state",
            0
          ],
          "destination": [
            "obj-channel_13__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_13__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_13__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_13__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__audible",
            0
          ],
          "destination": [
            "obj-channel_13__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_13__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_13__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_13__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            12
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_13__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            12
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_13__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_13__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_13__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__default",
            0
          ],
          "destination": [
            "obj-channel_14__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__fader",
            0
          ],
          "destination": [
            "obj-channel_14__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__db",
            0
          ],
          "destination": [
            "obj-channel_14__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__fader_set",
            0
          ],
          "destination": [
            "obj-channel_14__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__db",
            0
          ],
          "destination": [
            "obj-channel_14__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__linear",
            0
          ],
          "destination": [
            "obj-channel_14__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__ramp",
            0
          ],
          "destination": [
            "obj-channel_14__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__signal",
            0
          ],
          "destination": [
            "obj-channel_14__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gain",
            0
          ],
          "destination": [
            "obj-channel_14__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate",
            0
          ],
          "destination": [
            "obj-channel_14__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__switch_default",
            0
          ],
          "destination": [
            "obj-channel_14__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__switch_default",
            0
          ],
          "destination": [
            "obj-channel_14__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__solo",
            0
          ],
          "destination": [
            "obj-channel_14__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__solo_order",
            1
          ],
          "destination": [
            "obj-channel_14__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__mute",
            0
          ],
          "destination": [
            "obj-channel_14__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate_state",
            0
          ],
          "destination": [
            "obj-channel_14__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_14__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_14__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_14__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__audible",
            0
          ],
          "destination": [
            "obj-channel_14__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_14__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_14__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_14__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            13
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_14__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            13
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_14__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_14__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_14__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__default",
            0
          ],
          "destination": [
            "obj-channel_15__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__fader",
            0
          ],
          "destination": [
            "obj-channel_15__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__db",
            0
          ],
          "destination": [
            "obj-channel_15__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__fader_set",
            0
          ],
          "destination": [
            "obj-channel_15__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__db",
            0
          ],
          "destination": [
            "obj-channel_15__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__linear",
            0
          ],
          "destination": [
            "obj-channel_15__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__ramp",
            0
          ],
          "destination": [
            "obj-channel_15__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__signal",
            0
          ],
          "destination": [
            "obj-channel_15__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gain",
            0
          ],
          "destination": [
            "obj-channel_15__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate",
            0
          ],
          "destination": [
            "obj-channel_15__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__switch_default",
            0
          ],
          "destination": [
            "obj-channel_15__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__switch_default",
            0
          ],
          "destination": [
            "obj-channel_15__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__solo",
            0
          ],
          "destination": [
            "obj-channel_15__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__solo_order",
            1
          ],
          "destination": [
            "obj-channel_15__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__mute",
            0
          ],
          "destination": [
            "obj-channel_15__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate_state",
            0
          ],
          "destination": [
            "obj-channel_15__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_15__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_15__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_15__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__audible",
            0
          ],
          "destination": [
            "obj-channel_15__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_15__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_15__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_15__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            14
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_15__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            14
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_15__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_15__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_15__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__default",
            0
          ],
          "destination": [
            "obj-channel_16__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__fader",
            0
          ],
          "destination": [
            "obj-channel_16__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__db",
            0
          ],
          "destination": [
            "obj-channel_16__fader_set",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__fader_set",
            0
          ],
          "destination": [
            "obj-channel_16__fader",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__db",
            0
          ],
          "destination": [
            "obj-channel_16__linear",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__linear",
            0
          ],
          "destination": [
            "obj-channel_16__ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__ramp",
            0
          ],
          "destination": [
            "obj-channel_16__signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__signal",
            0
          ],
          "destination": [
            "obj-channel_16__gain",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gain",
            0
          ],
          "destination": [
            "obj-channel_16__gate",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate",
            0
          ],
          "destination": [
            "obj-channel_16__meter",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__switch_default",
            0
          ],
          "destination": [
            "obj-channel_16__solo",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__switch_default",
            0
          ],
          "destination": [
            "obj-channel_16__mute",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__solo",
            0
          ],
          "destination": [
            "obj-channel_16__solo_order",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__solo_order",
            1
          ],
          "destination": [
            "obj-channel_16__gate_state",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__mute",
            0
          ],
          "destination": [
            "obj-channel_16__gate_state",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate_state",
            0
          ],
          "destination": [
            "obj-channel_16__gate_unpack",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate_unpack",
            0
          ],
          "destination": [
            "obj-channel_16__audible",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate_unpack",
            1
          ],
          "destination": [
            "obj-channel_16__audible",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate_unpack",
            2
          ],
          "destination": [
            "obj-channel_16__audible",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__audible",
            0
          ],
          "destination": [
            "obj-channel_16__gate_ramp",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate_ramp",
            0
          ],
          "destination": [
            "obj-channel_16__gate_signal",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate_signal",
            0
          ],
          "destination": [
            "obj-channel_16__gate",
            1
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-output_bus",
            0
          ],
          "destination": [
            "obj-channel_16__gain",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__gate",
            0
          ],
          "destination": [
            "obj-output_dac",
            15
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-channel_16__solo_order",
            0
          ],
          "destination": [
            "obj-solo_states",
            15
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-any_solo",
            0
          ],
          "destination": [
            "obj-channel_16__gate_state",
            2
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_mute_value",
            0
          ],
          "destination": [
            "obj-channel_16__db",
            0
          ]
        }
      },
      {
        "patchline": {
          "source": [
            "obj-all_unity_value",
            0
          ],
          "destination": [
            "obj-channel_16__db",
            0
          ]
        }
      }
    ]
  }
}