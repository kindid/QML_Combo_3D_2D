import QtQuick 2.11
import QtQuick.Window 2.11
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.9
import QtQuick.Scene3D 2.0
import QtQuick.Controls 2.2
import Qt3D.Logic 2.1

Item {
    id: root
    property int frames: 0
    visible: true
    Scene3D {
        id: scene
        anchors.fill: parent
        Entity {
            id: sceneRoot
            FrameAction {
                onTriggered: {
                    print('go boom!')
                    root.frames++
                }
            }
            Camera {
                id: camera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 60
                aspectRatio: 16/9
                nearPlane : 0.1
                farPlane : 1000.0
                position: Qt.vector3d(0, 10, -20)
                upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
            }
            components: [
                RenderSettings {
                    activeFrameGraph: ForwardRenderer {
                        clearColor: Qt.rgba(0, 0.5, 1, 1)
                        camera: camera
                    }
                }
            ]
            NodeInstantiator {
                model: 20
                delegate: Entity {
                    components: [
                        // I think it runs from -5 to 5 man
                        PlaneMesh {
                            width: 5
                            height: 5
                        },
                        Transform {
                            scale: 1
                            rotationX: -90
                            //rotationY: 45
                            rotationY: (index / 20) * 360
                            translation: Qt.vector3d(Math.sin(index * Math.PI / 10) * 10,0,Math.cos(index * Math.PI / 10) * 10)
                        },
                        TextureMaterial {
                            texture: TextureLoader {
                                source: 'qrc:/images/tree.png'
                            }
                        }
                    ]
                }
            }
        }
    }
    Button {
        height: 20
        width: parent.width
        x: 0
        y: 0
        text: 'hi ' + root.frames
    }
}
