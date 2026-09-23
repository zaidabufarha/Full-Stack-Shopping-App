import { printSchema } from 'graphql'
import { writeFileSync } from 'fs'
import { join } from 'path'
import schema from '../src/graphql/schema'

// The schema lives as a template string inside buildSchema(), so there's no .graphql
// file for tooling to read. Print it to one so the web client's codegen has a source.
const out = join(__dirname, '..', 'schema.graphql')
writeFileSync(out, printSchema(schema))
console.log('wrote', out)
