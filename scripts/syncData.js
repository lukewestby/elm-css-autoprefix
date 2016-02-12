import fs from 'fs';
import path from 'path';

const filePath = path.resolve(__dirname, '../src/Css/Autoprefixer/Data.elm');

const emptyFile = () => {
  return new Promise((resolve, reject) => {
    fs.writeFile(filePath, '', (error) => {
      if (error) reject(error)
      else resolve()
    })
  })
}

const appendData = (data) => {
  return new Promise((resolve, reject) => {
    fs.appendFile(filePath, data, (error) => {
      if (error) reject(error)
      else resolve()
    })
  })
}

const appendFileIntro = () => {
  const data =
`module Css.Autoprefixer.Data where

import Css.Autoprefixer.Stats as Stats`

  return appendData(data);
}

const appendItem = (variableName, data) => {
  return appendData(`


${variableName} : List Stats.BrowserSupport
${variableName} =
  Stats.parseStats <|
    """
${JSON.stringify(data)}
    """`)
}

const execute = async () => {
  try {
    await emptyFile()
    await appendFileIntro()
    await Promise.all(Object.keys(importMap).map((key) => {
      const data = require(importMap[key]).stats
      return appendItem(key, data)
    }))
  } catch (error) {
    console.log('failed to generate code:')
    console.log(error.message)
  }
}

const importMap = {
  borderRadius: 'caniuse-db/features-json/border-radius.json',
  boxShadow: 'caniuse-db/features-json/css-boxshadow.json',
  animation: 'caniuse-db/features-json/css-animation.json',
  transition: 'caniuse-db/features-json/css-transitions.json',
  transforms2d: 'caniuse-db/features-json/transforms2d.json',
  transforms3d: 'caniuse-db/features-json/transforms3d.json',
  gradients: 'caniuse-db/features-json/css-gradients.json',
  boxSizing: 'caniuse-db/features-json/css3-boxsizing.json',
  filter: 'caniuse-db/features-json/css-filters.json',
  filterFunction: 'caniuse-db/features-json/css-filter-function.json',
  backdropFilter: 'caniuse-db/features-json/css-backdrop-filter.json',
  elementFunction: 'caniuse-db/features-json/css-element-function.json',
  multicolumn: 'caniuse-db/features-json/multicolumn.json',
  userSelectNone: 'caniuse-db/features-json/user-select-none.json',
  flexbox: 'caniuse-db/features-json/flexbox.json',
  calc: 'caniuse-db/features-json/calc.json',
  backgroundImgOpts: 'caniuse-db/features-json/background-img-opts.json',
  fontFeature: 'caniuse-db/features-json/font-feature.json',
  borderImage: 'caniuse-db/features-json/border-image.json',
  selection: 'caniuse-db/features-json/css-selection.json',
  placeholder: 'caniuse-db/features-json/css-placeholder.json',
  hyphens: 'caniuse-db/features-json/css-hyphens.json',
  fullscreen: 'caniuse-db/features-json/fullscreen.json',
  tabSize: 'caniuse-db/features-json/css3-tabsize.json',
  intrinsicWidth: 'caniuse-db/features-json/intrinsic-width.json',
  cursorsNewer: 'caniuse-db/features-json/css3-cursors-newer.json',
  cursorsGrab: 'caniuse-db/features-json/css3-cursors-grab.json',
  sticky: 'caniuse-db/features-json/css-sticky.json',
  pointer: 'caniuse-db/features-json/pointer.json',
  textDecoration: 'caniuse-db/features-json/text-decoration.json',
  textSizeAdjust: 'caniuse-db/features-json/text-size-adjust.json',
  boxDecorationBreak: 'caniuse-db/features-json/css-boxdecorationbreak.json',
  objectFit: 'caniuse-db/features-json/object-fit.json',
  shapes: 'caniuse-db/features-json/css-shapes.json',
  textOverflow: 'caniuse-db/features-json/text-overflow.json',
  deviceAdaptation: 'caniuse-db/features-json/css-deviceadaptation.json',
  mediaResolution: 'caniuse-db/features-json/css-media-resolution.json',
  textAlignLast: 'caniuse-db/features-json/css-text-align-last.json',
  crispEdges: 'caniuse-db/features-json/css-crisp-edges.json',
  logicalProps: 'caniuse-db/features-json/css-logical-props.json',
  appearance: 'caniuse-db/features-json/css-appearance.json',
  snappoint: 'caniuse-db/features-json/css-snappoints.json',
  regions: 'caniuse-db/features-json/css-regions.json',
  imageSet: 'caniuse-db/features-json/css-image-set.json',
  writingMode: 'caniuse-db/features-json/css-writing-mode.json',
  crossFade: 'caniuse-db/features-json/css-cross-fade.json',
  readOnlyWrite: 'caniuse-db/features-json/css-read-only-write.json',
  textEmphasis: 'caniuse-db/features-json/text-emphasis.json',
  grid: 'caniuse-db/features-json/css-grid.json',
  textSpacing: 'caniuse-db/features-json/css-text-spacing.json',
};

execute();
