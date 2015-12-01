// Copyright 2015 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import QtQuick 2.3
import QtQuick.Controls 1.2
import Esri.Samples 1.0
import Esri.ArcGISExtras 1.1

DisplayDeviceLocationSample {
    id: deviceLocationSample
    width: 800
    height: 600

    property double scaleFactor: System.displayScaleFactor
    property string currentModeText: "Stop"
    property string currentModeImage: "qrc:/Samples/Maps/DisplayDeviceLocation/Stop.png"

    // add a mapView component
    MapView {
        anchors.fill: parent
        objectName: "mapView"
    }

    Rectangle {
        id: rect
        anchors.fill: parent
        visible: autoPanListView.visible
        color: "black"
        opacity: 0.7
    }

    ListModel {
        id: autoPanListModel
        ListElement {name: "Compass"; image: "qrc:/Samples/Maps/DisplayDeviceLocation/Compass.png"}
        ListElement {name: "Navigation"; image: "qrc:/Samples/Maps/DisplayDeviceLocation/Navigation.png"}
        ListElement {name: "Re-Center"; image: "qrc:/Samples/Maps/DisplayDeviceLocation/Re-Center.png"}
        ListElement {name: "On"; image: "qrc:/Samples/Maps/DisplayDeviceLocation/On.png"}
        ListElement {name: "Stop"; image: "qrc:/Samples/Maps/DisplayDeviceLocation/Stop.png"}
        ListElement {name: "Close"; image: "qrc:/Samples/Maps/DisplayDeviceLocation/Close.png"}
    }

    ListView {
        id: autoPanListView
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 10 * scaleFactor
        }
        visible: false
        width: parent.width
        height: 300
        spacing: 10 * scaleFactor
        model: autoPanListModel

        delegate: Row {
            id: autopanRow
            anchors.right: parent.right
            spacing: 10

            Text {
                text: name
                font.pixelSize: 25 * scaleFactor
                color: "white"
                MouseArea {
                    anchors.fill: parent
                    // When an item in the list view is clicked
                    onClicked: {
                       autopanRow.updateAutoPanMode();
                    }
                }
            }

            Image {
                source: image
                width: 40 * scaleFactor
                height: width
                MouseArea {
                    anchors.fill: parent
                    // When an item in the list view is clicked
                    onClicked: {
                       autopanRow.updateAutoPanMode();
                    }
                }
            }

            // set the appropriate auto pan mode
            function updateAutoPanMode() {
                switch (name) {
                case "Compass":
                    deviceLocationSample.setAutoPanMode("Compass");
                    break;
                case "Navigation":
                    deviceLocationSample.setAutoPanMode("Navigation");
                    break;
                case "Re-Center":
                    deviceLocationSample.setAutoPanMode("Default");
                    break;
                case "On":
                    deviceLocationSample.startLocationDisplay();
                    deviceLocationSample.setAutoPanMode("Off");
                    break;
                case "Stop":
                    deviceLocationSample.stopLocationDisplay();
                    break;
                }

                if (name !== "Close") {
                    currentModeText = name;
                    currentModeImage = image;
                }

                // hide the list view
                currentAction.visible = true;
                autoPanListView.visible = false;
            }
        }
    }

    Row {
        id: currentAction
        anchors {
            right: parent.right
            bottom: parent.bottom
            margins: 10 * scaleFactor
        }
        spacing: 10

        Text {
            text: currentModeText
            font.pixelSize: 25 * scaleFactor
            color: "white"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentAction.visible = false;
                    autoPanListView.visible = true;
                }
            }
        }

        Image {
            source: currentModeImage
            width: 40 * scaleFactor
            height: width
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    currentAction.visible = false;
                    autoPanListView.visible = true;
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }
}


