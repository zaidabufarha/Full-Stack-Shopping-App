import { buildSchema } from 'graphql';

export default buildSchema(`
    type User {
        id: ID!
        name: String!
        email: String!
        phone: String!
        image_path: String!
        default_address_id: ID
        default_credit_card_id: ID
        notification_preference: NotificationPreference!
        address: [Address!]!
        credit_card: [CreditCard!]!
        order: [Order!]!
        transaction: [Transaction!]!
        favorite: [Product!]!
    }

    type NotificationPreference {
        id: ID!
        user_id: ID!
        allow_general: Boolean!
        allow_order: Boolean!
        allow_email: Boolean!
    }

    type Address {
        id: ID!
        user_id: ID!
        name: String!
        street: String!
        city: String!
        state: String!
        zip_code: String!
        country: String!
        phone: String!
    }

    type CreditCard {
        id: ID!
        user_id: ID!
        card_holder_name: String!
        card_number: String!
        expiry_date: String!
        cvv: String!
        processor: String!
    }

    type Category {
        id: ID!
        name: String!
        image_path: String!
        color: String!
    }

    type Product {
        id: ID!
        category_id: ID!
        name: String!
        image_path: String!
        amount: String!
        description: String!
        discount: Float!
        price: Float!
        is_new: Boolean!
        is_favorite: Boolean!
        free_shipping: Boolean!
        same_day_delivery: Boolean!
        color: String!
        rating: Float!
        category: Category
        review: [Review!]!
    }

    type Review {
        id: ID!
        product_id: ID!
        user_id: ID!
        user: User
        product: Product
        rating: Float!
        comment: String!
        created_at: String!
    }

    type CartItem {
        id: ID!
        user_id: ID!
        product_id: ID!
        product: Product!
        quantity: Int!
    }

    type Order {
        id: ID!
        user_id: ID!
        address_id: ID!
        card_id: ID!
        address: Address
        credit_card: CreditCard
        shipping_method: String!
        total_amount: Float!
        status: String!
        date_placed: String!
        date_confirmed: String
        date_shipped: String
        date_out_for_delivery: String
        date_delivered: String
        order_item: [OrderItem!]!
        transaction: [Transaction!]!
    }

    type OrderItem {
        id: ID!
        order_id: ID!
        product_id: ID!
        product: Product!
        quantity: Int!
        price_at_purchase: Float!
    }

    type Transaction {
        id: ID!
        user_id: ID!
        order_id: ID!
        amount: Float!
        status: String!
        payment_method: String!
        created_at: String!
    }

    type AuthPayload {
        token: String!
        user: User!
    }

    input SignUpInput {
        name: String!
        email: String!
        password: String!
        phone: String!
    }

    input UpdateProfileInput {
        name: String
        email: String
        phone: String
        image_path: String
    }

    input AddressInput {
        name: String!
        street: String!
        city: String!
        state: String!
        zip_code: String!
        country: String!
        phone: String!
        is_default: Boolean
    }

    input CardInput {
        card_holder_name: String!
        card_number: String!
        expiry_date: String!
        cvv: String!
        processor: String!
        is_default: Boolean
    }

    input ProductFilterInput {
        category_id: ID
        search: String
        min_rating: Float
        min_price: Float
        max_price: Float
        discount_only: Boolean
        free_shipping_only: Boolean
        same_day_delivery_only: Boolean
        limit: Int
        offset: Int
    }

    type RootQuery {
        me: User!
        categories: [Category!]!
        category(id: ID!): Category!
        products(filter: ProductFilterInput): [Product!]!
        product(id: ID!): Product!
        productReviews(product_id: ID!): [Review!]!
        cart: [CartItem!]!
        order(id: ID!): Order!
    }

    type RootMutation {
        signUp(email: String!, number: String!, password: String!): User!
        logIn(email: String!, password: String!): AuthPayload!
        forgotPassword(email: String!): Boolean!
        updateProfile(input: UpdateProfileInput!): User!
        changePassword(oldPassword: String!, newPassword: String!): Boolean!
        updateNotificationPreference(allow_general: Boolean, allow_order: Boolean, allow_email: Boolean): NotificationPreference!

        addAddress(input: AddressInput!): Address!
        updateAddress(id: ID!, input: AddressInput!): Address!
        deleteAddress(id: ID!): Boolean!
        setDefaultAddress(id: ID!): Address!

        addCard(input: CardInput!): CreditCard!
        deleteCard(id: ID!): Boolean!
        setDefaultCard(id: ID!): CreditCard!

        addToCart(product_id: ID!, quantity: Int!): CartItem!
        updateCartItem(cart_item_id: ID!, quantity: Int!): CartItem!
        removeFromCart(cart_item_id: ID!): Boolean!
        clearCart: Boolean!

        toggleFavorite(product_id: ID!): Boolean!

        createOrder(address_id: ID!, card_id: ID!, shipping_method: String): Order!
        addReview(product_id: ID!, rating: Float!, comment: String!): Review!
    }

    schema {
        query: RootQuery
        mutation: RootMutation
    }
`);
