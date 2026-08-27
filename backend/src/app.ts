import 'dotenv/config'
import express from 'express'
import { graphqlHTTP } from 'express-graphql'
import bodyParser from 'body-parser'
import graphqlSchema from './graphql/schema'
import graphqlResolver from './graphql/resolvers'
import isAuth from './middleware/is-auth'

const requiredEnvVars = ['JWT_SECRET', 'DATABASE_URL', 'RESEND_API_KEY'];
for (const envVar of requiredEnvVars) {
    if (!process.env[envVar]) {
        throw new Error(`Missing required environment variable: ${envVar}`);
    }
}

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
if (process.env.NODE_ENV !== 'test') {
    app.listen(process.env.PORT || 4321)
}

export default app;