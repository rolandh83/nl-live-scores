/*
 * Copyright 2014-2018 Roland Hostettler
 *
 * This file is part of swisshockey.
 *
 * swisshockey is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 *
 * swisshockey is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * swisshockey. If not, see http://www.gnu.org/licenses/.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

import "utils.js" as Utils

Page {
    property alias leagueName: pulleyMenu.leagueName

    function startUpdateIndicator() {
//        updateIndicator.running = true;
//        updateIndicator.visible = true;
    }

    function stopUpdateIndicator() {
//        updateIndicator.running = false;
//        updateIndicator.visible = false;
    }

    LeagueSelectionDialog {
        id: leagueSelectionDialog
    }

    PreferencesDialog {
        id: preferencesDialog
    }

/*    // A spinning busy indicator shown while the data is loading upon
    // application start
    BusyIndicator {
        id: updateIndicator
        anchors {
            right: selectorIcon.left
            rightMargin: 32
            verticalCenter: parent.verticalCenter
        }

        platformStyle: BusyIndicatorStyle {
            size: "small"
            inverted: true
        }
        visible: false
        running: false
        //running: gameList.count == 0
        //visible: gameList.count == 0
    }*/

//    property bool bannerStart: false

    SilicaListView {
        id: gameList
        model: listData
        anchors.fill: parent

        delegate: GameOverviewDelegate {
            id: gameDelegate
        }

        VerticalScrollDecorator{}

        PullDownMenu {
            id: pulleyMenu
            property string leagueName: "All"

            /*
            MenuItem {
                text: qsTr("Preferences")
                onClicked: pageStack.push(preferencesDialog)
            }*/

            MenuItem {
                text: qsTr("Update")
                onClicked: appWindow.updateTriggered()
            }
            MenuItem {
                text: qsTr("League: ") + leagueName
                onClicked: pageStack.push(leagueSelectionDialog)
            }
        }
    }

    // TODO: This should actually be inside the ListView, but that will place it
    // strangely so we put it here and take the error.
    ViewPlaceholder{
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        enabled: gameList.count === 0
        text: qsTr("No games today.");
        //hintText: qsTr("")
    }
}
