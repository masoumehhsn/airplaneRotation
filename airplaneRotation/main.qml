import QtQuick 2.12
import Qt3D.Core 2.0
import Qt3D.Render 2.9
import Qt3D.Input 2.0
import Qt3D.Extras 2.0
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Scene3D 2.14
import QtQuick.Controls 2.5
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.1

Window {
    property int margin: 10
    property int currentRollAngle
    property int targetRollAngle
    property int currentPitchAngle
    property int targetPitchAngle
    property bool completeLoad: false
    Material.theme:Material.Dark
    width: mainLayout.implicitWidth + 2 * margin
    height: mainLayout.implicitHeight + 2 * margin
    minimumWidth: mainLayout.Layout.minimumHeight
    minimumHeight: mainLayout.Layout.minimumHeight
    visible: true
    title: qsTr("airplane")
    color: "#494949"
    Component.onCompleted: {
        completeLoad = true
    }
    onWidthChanged: {
        if(completeLoad)
            plane.scaleFactor= Math.round(mainLayout.width/sceneItem.width * 10) / 10

    }



    RowLayout{
        id:mainLayout
        anchors.fill: parent
        spacing: 0

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredHeight: 450
            Layout.preferredWidth: 120
            Column {
                width: parent.width*0.5
                height: parent.height*0.95
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                RoundButton{
                    id:roll0
                    height:width
                    icon.height: height
                    icon.width: height
                    width: parent.width
                    icon.source: "qrc:/icon/roll0d.svg"
                    onClicked: {

                        rollRotation(-15)
                    }
                }

                RoundButton{
                    id:roll90
                    icon.source: "qrc:/icon/roll90d.svg"
                    height:width
                    icon.height: height
                    icon.width: height
                    width: parent.width
                    onClicked: {
                        rollRotation(-110)

                    }

                }
                RoundButton{
                    id:roll270
                    icon.source: "qrc:/icon/roll270d.svg"
                    height:width
                    icon.height: height
                    icon.width: height
                    width: parent.width

                    onClicked: {
                        rollRotation(70)
                    }
                }
                RoundButton
                {
                    id:pitch90
                    icon.source: "qrc:/icon/pitch90d.svg"
                    height:width
                    icon.height: height
                    icon.width: height

                    width: parent.width

                    onClicked: {
                        pitchRotation(110)
                    }
                }
                RoundButton
                {
                    id:pitch180
                    icon.source: "qrc:/icon/pitch180d.svg"
                    height:width
                    icon.height: height
                    icon.width: height

                    width: parent.width

                    onClicked: {
                        pitchRotation(190)

                    }
                }
                RoundButton
                {
                    id:pitch270
                    icon.source: "qrc:/icon/pitch270d.svg"
                    height:width
                    icon.height: height
                    icon.width: height

                    width: parent.width

                    onClicked: {
                        pitchRotation(290)

                    }
                }
            }
        }

        Item{
            id:sceneItem
            Layout.preferredHeight: 450
            Layout.preferredWidth: 600
            Layout.fillWidth: true
            Layout.fillHeight: true

            Scene3D {
                id: scene3dInstance
                anchors.fill: parent
                focus: true
                cameraAspectRatioMode: Scene3D.AutomaticAspectRatio
                multisample: true

            }
            Scene3DView {
                width: parent.width
                height: parent.height
                scene3D: scene3dInstance

                anchors.fill: parent
                AirplaneScene{
                    id:plane

                    NumberAnimation
                    {
                        id:planeRollAnimation
                        target: plane
                        property: "rollAngle"
                        from: currentRollAngle
                        to: targetRollAngle
                        duration:2000
                        running: false
                    }
                    NumberAnimation
                    {
                        id:planePitchAnimation
                        target: plane
                        property: "pitchAngle"
                        from: currentPitchAngle
                        to: targetPitchAngle
                        duration:2000
                        running: false
                    }

                }
            }


        }
    }
    function rollRotation(degree){
        if(plane.pitchAngle != 0)
        {
            targetPitchAngle = 0
            currentPitchAngle = plane.pitchAngle
            planePitchAnimation.running = true


        }
        currentRollAngle = plane.rollAngle
        targetRollAngle = degree
        planeRollAnimation.running = true

    }
    function pitchRotation(degree){
        if(plane.rollAngle != 0)
        {
            targetRollAngle = 0
            currentRollAngle = plane.rollAngle
            planeRollAnimation.running = true


        }
        currentPitchAngle = plane.pitchAngle
        targetPitchAngle = degree
        planePitchAnimation.running = true
    }
}
