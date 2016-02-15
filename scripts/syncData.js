import fs from 'fs';
import path from 'path';
import autoprefixer from 'autoprefixer';

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

const appendPrefixes = (data) => {
  return appendData(`


prefixes : Dict String Stats.Requirement
prefixes =
  Stats.parseRequirements <|
    """
${JSON.stringify(data)}
    """`)
}


const execute = async () => {
  try {
    await emptyFile()
    await appendFileIntro()
    await appendPrefixes(autoprefixer.data.prefixes)
  } catch (error) {
    console.log('failed to generate code:')
    console.log(error.message)
  }
}

execute();
