import express from 'express'
import { graphqlHTTP } from 'express-graphql'
import bodyParser from 'body-parser'
import graphqlSchema from './graphql/schema'
import graphqlResolver from './graphql/resolvers'
const isAuth = require('./middleware/is-auth')

const app = express()

app.use(bodyParser.json())

app.use((req: any, res: any, next: any) => {
    res.setHeader('Access-Control-Allow-Origin', '*')
    res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,PATCH,DELETE')
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
    if (req.method === 'OPTIONS') { //this simplifies communication with clients
        return res.sendStatus(200)
    }
    next()
})

app.use(isAuth)

app.use('/graphql', graphqlHTTP({
    schema: graphqlSchema,
    rootValue: graphqlResolver,
    graphiql: true

}))
app.listen(process.env.PORT || 4321)