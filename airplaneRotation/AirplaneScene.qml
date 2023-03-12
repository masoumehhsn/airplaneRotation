import QtQuick 2.0
import Qt3D.Core 2.14
import Qt3D.Render 2.14
import Qt3D.Input 2.14
import Qt3D.Extras 2.14


Entity {
    id: sceneRoot
    property bool clearColor: false
    property real rollAngle: -15
    property real pitchAngle:10
    property real angle: 260
    property real scaleFactor:1.3
    Camera {
        id: camera
        projectionType: CameraLens.PerspectiveProjection
        fieldOfView: 45
        position: Qt.vector3d( 25.0, 30.0, 25.0 )
        upVector: Qt.vector3d( 0.0, 0.0, 0.0 )
        viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
    }

    OrbitCameraController {
        camera: camera
    }
    components: [
        RenderSettings {
            activeFrameGraph: ForwardRenderer {
                camera: camera
                clearColor: "transparent"
            }
        },
        InputSettings { }
    ]

    PhongMaterial {
        id: material
    }
    PhongMaterial {
        id: planematerial
        ambient: "#CACACA"
        diffuse: "#A4A4A4"
    }

    Mesh {
        id: toyplaneMesh
        source: "qrc:/obj/toyplane.obj"

    }
    Transform {
        id: toyplaneTransform

        matrix: {
            var m = Qt.matrix4x4();
            m.translate(Qt.vector3d(-30, -25, -30));
            m.rotate(angle, Qt.vector3d(0, 1, 0));
            m.rotate(rollAngle, Qt.vector3d(1, 0, 0));
            m.rotate(pitchAngle, Qt.vector3d(0, 0,1));
            m.scale(1.0 /scaleFactor );
            return m;
        }


    }


    Entity {
        id: toyplaneEntity

        components: [
            toyplaneMesh,
            toyplaneTransform,
            planematerial
        ]
    }

    PlaneMesh {
        id: groundMesh
        width: 150
        height: width
        meshResolution: Qt.size(4, 4)

    }

    Transform {
        id: groundTransform
        matrix: {
            var m = Qt.matrix4x4();
            var m = Qt.matrix4x4();
            m.translate(Qt.vector3d(-60, -55, -65));
            m.rotate(-10, Qt.vector3d(0, 1, 0));
            m.rotate(-10, Qt.vector3d(1, 0, 0));
            m.scale(1.0 / scaleFactor);

            return m;
        }

    }
    Entity{
    components: [
        groundMesh,
        groundTransform,
        material
    ]
}
}
