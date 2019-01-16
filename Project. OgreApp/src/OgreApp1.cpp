/*
-----------------------------------------------------------------------------
Filename:    OgreApp1.cpp
-----------------------------------------------------------------------------
*/

#include "OgreApp1.h"

//-------------------------------------------------------------------------------------
OgreApp1::OgreApp1(void)
{
}
//-------------------------------------------------------------------------------------
OgreApp1::~OgreApp1(void)
{
}

//-------------------------------------------------------------------------------------

// ��������� �����
void OgreApp1::buildModel(Ogre::Vector3 *vertices, int vertexCount) 
{
	float *pVertex1 = static_cast<float *>(vertexBuffer->lock(Ogre::HardwareBuffer::HBL_DISCARD));

	for(int i=0; i<vertexCount; i++){
		pVertex1[i*3]   = vertices[i].x;
		pVertex1[i*3+1] = vertices[i].y;
		pVertex1[i*3+2] = vertices[i].z;
	}

    vertexBuffer->unlock();
}

void OgreApp1::createScene(void)
{
	//----------------------------------------------------
	// ������ �� �����
	//----------------------------------------------------
	ifstream file;
	file.open("mesh.gms");

	string temp;

	do{
		getline(file, temp);
	} while (temp != "numverts numfaces");

	file>>vertexCount; 
	file>>facesCount;  

	// ������� ��� �������� ����
	vertices      = new Ogre::Vector3[vertexCount];
	faces         = new Ogre::Vector3[facesCount];
	normalsFacet  = new Ogre::Vector3[facesCount];
	normalsSmooth = new Ogre::Vector3[vertexCount];

	getline(file, temp); // ������ ������
	getline(file, temp); // ������ "Mesh vertices:"  

	for(int i=0; i<vertexCount; i++){
		file>>vertices[i].x;
		file>>vertices[i].y;
		file>>vertices[i].z;
	}

	getline(file, temp); // ������ ������
	getline(file, temp); // ������ "end vertices"
	getline(file, temp); // ������ "Mesh faces:"

	for(int i=0; i<facesCount; i++){
		file>>faces[i].x; faces[i].x--;
		file>>faces[i].y; faces[i].y--;
		file>>faces[i].z; faces[i].z--;
	}

	getline(file, temp); // ������ ������
	getline(file, temp); // ������ "end faces"
	getline(file, temp); // ������ "Faset normals:"

	for(int i=0; i<facesCount; i++){
		file>>normalsFacet[i].x;
		file>>normalsFacet[i].y;
		file>>normalsFacet[i].z;
	}

	getline(file, temp); // ������ ������
	getline(file, temp); // ������ "end faset normals"
	getline(file, temp); // ������ "Smooth normals:"

	for(int i=0; i<vertexCount; i++){
		file>>normalsSmooth[i].x;
		file>>normalsSmooth[i].y;
		file>>normalsSmooth[i].z;
	}
	//----------------------------------------------------

	/* ������������� ������� submesh */
    Ogre::MeshPtr mesh = Ogre::MeshManager::getSingleton().createManual("CustomMesh", "General");
    Ogre::SubMesh *subMesh = mesh->createSubMesh();
 
    /* �������������� ��������� ��� ������ */
    mesh->sharedVertexData = new Ogre::VertexData;
    mesh->sharedVertexData->vertexCount = facesCount*3;
 
    /* �������� ������ �� ���������� ������ (��������� ���������) */
    Ogre::VertexDeclaration *decl = mesh->sharedVertexData->vertexDeclaration;
    size_t offset = 0;
 
    /* ������ ������� ������ - ��� ���� ������� (�� ����������) */
    decl->addElement(0, offset, Ogre::VET_FLOAT3, Ogre::VES_POSITION);
    offset += Ogre::VertexElement::getTypeSize(Ogre::VET_FLOAT3);
  
    /* ���������� ���������� ����� �� ��������, ������� ���� */
    vertexBuffer = Ogre::HardwareBufferManager::getSingleton().
        createVertexBuffer(offset, mesh->sharedVertexData->vertexCount, Ogre::HardwareBuffer::HBU_STATIC);

    /* ��������� ����� �� ������ � ����� ��������� �� ���� */
    float *pVertex = static_cast<float *>(vertexBuffer->lock(Ogre::HardwareBuffer::HBL_DISCARD));

	/* ������� �������� ������ */
	for(int i=0; i<vertexCount; i++){
		*pVertex++ = vertices[i].x;
		*pVertex++ = vertices[i].y;
		*pVertex++ = vertices[i].z;
	}

    /* ������������ */
    vertexBuffer->unlock();
 
    /* ������� ����� ��� �������� */
    Ogre::HardwareIndexBufferSharedPtr indexBuffer = Ogre::HardwareBufferManager::getSingleton().
        createIndexBuffer(Ogre::HardwareIndexBuffer::IT_16BIT, mesh->sharedVertexData->vertexCount, Ogre::HardwareBuffer::HBU_STATIC);
 
    /* �������� ���������� �� ������ � ����� ������� � ����� */
    uint16_t *indices = static_cast<uint16_t *>(indexBuffer->lock(Ogre::HardwareBuffer::HBL_NORMAL));

    /* ������ ������ ������� ������, ������� ����� ������ ������������ */
	for(int i=0; i<facesCount; i++){
		indices[i*3]   = faces[i].x;
		indices[i*3+1] = faces[i].y;
		indices[i*3+2] = faces[i].z;
	}

    /* �������� - �������������� */
    indexBuffer->unlock();
 
    /* ������ ���� ��������� � ����� ��������� ��������� ����� */
    mesh->sharedVertexData->vertexBufferBinding->setBinding(0, vertexBuffer);
    subMesh->useSharedVertices = true;
    subMesh->indexData->indexBuffer = indexBuffer;
    subMesh->indexData->indexCount = mesh->sharedVertexData->vertexCount;
    subMesh->indexData->indexStart = 0;
 
    /* ���� �� �������� �����, �� ��� �� ������ ��������� ��������� �����*/
    mesh->_setBounds(Ogre::AxisAlignedBox(-1, -1, -1, 1, 1, 1));
 
    /* ���������� - ������ */
    mesh->load();




	//-------------------------------------------------------------------------
	Ogre::ManualObject* manual2 = mSceneMgr->createManualObject("PointNormals");
	manual2->begin("BaseWhiteNoLighting", Ogre::RenderOperation::OT_POINT_LIST);

	for(int i=0; i<vertexCount; i++){
		manual2->position(normalsSmooth[i].x, normalsSmooth[i].y, normalsSmooth[i].z); manual2->colour(0,1,0,1);
	}

	manual2->end();
	manual2->convertToMesh("PointNormals");
	//-------------------------------------------------------------------------






	Ogre::Entity *entCube = mSceneMgr->createEntity("CustomEntity", "CustomMesh", "General");
	Ogre::Entity *entPointNormals = mSceneMgr->createEntity("PointNormals");

    Ogre::SceneNode *node = mSceneMgr->getRootSceneNode()->createChildSceneNode();

	node->attachObject(entCube);
	//node->attachObject(entPointNormals);

	node->scale(70.0f,70.0f,70.0f);
}

#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
#define WIN32_LEAN_AND_MEAN
#include "windows.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
    INT WINAPI WinMain( HINSTANCE hInst, HINSTANCE, LPSTR strCmdLine, INT )
#else
    int main(int argc, char *argv[])
#endif
    {
        // Create application object
		OgreApp1 app;
        try {
            app.go();
        } catch( Ogre::Exception& e ) {
#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
            MessageBox( NULL, e.getFullDescription().c_str(), "An exception has occured!", MB_OK | MB_ICONERROR | MB_TASKMODAL);
#else
            std::cerr << "An exception has occured: " <<
                e.getFullDescription().c_str() << std::endl;
#endif
        }

        return 0;
    }

#ifdef __cplusplus
}
#endif
