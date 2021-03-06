/****************************************************************************
* MeshLab                                                           o o     *
* An extendible mesh processor                                    o     o   *
*                                                                _   O  _   *
* Copyright(C) 2005, 2009                                          \/)\/    *
* Visual Computing Lab                                            /\/|      *
* ISTI - Italian National Research Council                           |      *
*                                                                    \      *
* All rights reserved.                                                      *
*                                                                           *
* This program is free software; you can redistribute it and/or modify      *
* it under the terms of the GNU General Public License as published by      *
* the Free Software Foundation; either version 2 of the License, or         *
* (at your option) any later version.                                       *
*                                                                           *
* This program is distributed in the hope that it will be useful,           *
* but WITHOUT ANY WARRANTY; without even the implied warranty of            *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             *
* GNU General Public License (http://www.gnu.org/licenses/gpl.txt)          *
* for more details.                                                         *
*                                                                           *
****************************************************************************/

#ifndef _ARC3D_RECONSTRUCTION_H
#define _ARC3D_RECONSTRUCTION_H

#include <QtXml>

#include <common/meshmodel.h>

#include "radial_distortion.h"
#include "arc3D_camera.h"
#include "scalar_image.h"


class Arc3DModel
{
public:
    int index;
    QString cameraName;
    QString maskName;
    QString depthName;
    QString textureName;
    QString countName;
    vcg::Arc3DCamera cam;
    Shotm shot;
    bool Init(QDomNode &node);
    static QString ThumbName(QString &imageName);

    bool BuildMesh(CMeshO &m, int subsampleFactor, int minCount, float minAngleCos, int smoothSteps,
        bool dilation, int dilationPasses, int dilationSize, bool erosion, int erosionPasses, int erosionSize,float scalingFactor);
    Point3m TraCorrection(CMeshO &m, int subsampleFactor, int minCount, int smoothSteps);
    void SmartSubSample(int subsampleFactor, FloatImage &fli, CharImage &chi, FloatImage &subD,FloatImage &subQ, int minCount);
    void AddCameraIcon(CMeshO &m);
    bool CombineHandMadeMaskAndCount(CharImage &qualityImg, QString maskName );
    void GenerateCountImage();
    void GenerateGradientSmoothingMask(int subsampleFactor, QImage &OriginalTexture, CharImage &mask);
    void Laplacian2(FloatImage &depth, FloatImage &Q, int minCount, CharImage &mask, float depthThr);
    float ComputeDepthJumpThr(FloatImage &depthImgf, float percentile);
    void depthFilter(FloatImage &depthImgf, FloatImage &countImgf, float depthJumpThr, 
        bool dilation, int dilationNumPasses, int dilationWinsize, bool erosion, int erosionNumPasses, int erosionWinsize);

    QIcon *getIcon();
};

class Arc3DReconstruction
{
public:
    QString name, author, created;
    QList<Arc3DModel> modelList;
};

#endif