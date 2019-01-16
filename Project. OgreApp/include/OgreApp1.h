/*
-----------------------------------------------------------------------------
Filename:    OgreApp1.h
-----------------------------------------------------------------------------
*/

#ifndef __OgreApp1_h_
#define __OgreApp1_h_

#include "BaseApplication.h"
#if OGRE_PLATFORM == OGRE_PLATFORM_WIN32
#include "../res/resource.h"
#endif


class OgreApp1 : public BaseApplication
{
public:
    OgreApp1(void);
    virtual ~OgreApp1(void);
	void buildModel(Ogre::Vector3 *vertices, int vertexCount);

protected:
    virtual void createScene(void);
	Ogre::HardwareVertexBufferSharedPtr vertexBuffer;
};



#endif // #ifndef __OgreApp1_h_
