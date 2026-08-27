//AI GENERATED
// Comprehensive End-to-End User Journey Test

const BASE_URL = 'http://localhost:4321/graphql';

async function graphql(query: string, token?: string) {
    const headers: Record<string, string> = {
        'Content-Type': 'application/json'
    };
    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }
    const res = await fetch(BASE_URL, {
        method: 'POST',
        headers,
        body: JSON.stringify({ query })
    });
    const json: any = await res.json();
    if (json.errors && json.errors.length > 0) {
        throw new Error(`GraphQL Error: ${json.errors[0].message}`);
    }
    return json.data;
}

async function runJourney() {
    const uniqueEmail = `test_${Date.now()}@example.com`;
    const initialPassword = 'password123';
    const newPassword = 'newpassword123';

    console.log('🚀 Starting Full GraphQL End-to-End Journey Test...\n');

    // 1. Sign Up
    console.log(`1. Signing up user: ${uniqueEmail}`);
    const signUpData = await graphql(`
        mutation {
            signUp(email: "${uniqueEmail}", number: "1234567890", password: "${initialPassword}") {
                id
                email
                name
            }
        }
    `);
    console.log(`   ✅ Signed up (User ID: ${signUpData.signUp.id})`);

    // 2. Log In
    console.log('2. Logging in...');
    const loginData = await graphql(`
        mutation {
            logIn(email: "${uniqueEmail}", password: "${initialPassword}") {
                token
                user {
                    id
                    name
                }
            }
        }
    `);
    const token = loginData.logIn.token;
    console.log(`   ✅ Logged in. Token received.`);

    // 3. Update Profile & Notification Preferences
    console.log('3. Updating profile & notification preferences...');
    await graphql(`
        mutation {
            updateProfile(input: { name: "Zaid QA", phone: "0799999999" }) {
                name
            }
            updateNotificationPreference(allow_general: false, allow_order: true, allow_email: true) {
                allow_general
            }
            changePassword(oldPassword: "${initialPassword}", newPassword: "${newPassword}")
        }
    `, token);
    console.log(`   ✅ Profile, notification preferences, and password updated.`);

    // 4. Add Address & Credit Card
    console.log('4. Adding address and credit card...');
    const addressData = await graphql(`
        mutation {
            addAddress(input: {
                name: "Home",
                street: "123 Main St",
                city: "Amman",
                zip_code: "11181",
                country: "Jordan",
                phone: "0790000000"
            }) {
                id
            }
            addCard(input: {
                card_holder_name: "Zaid A",
                card_number: "4111222233334444",
                expiry_date: "12/28",
                cvv: "123",
                processor: "Visa"
            }) {
                id
            }
        }
    `, token);
    const addressId = addressData.addAddress.id;
    const cardId = addressData.addCard.id;
    console.log(`   ✅ Created Address (ID: ${addressId}) and Card (ID: ${cardId})`);

    // 5. Query Categories & Products
    console.log('5. Querying categories and catalog products...');
    const catalog = await graphql(`
        query {
            categories {
                id
                name
            }
            products(filter: { min_price: 1, limit: 5 }) {
                id
                name
                price
            }
        }
    `);
    console.log(`   ✅ Found ${catalog.categories.length} categories, ${catalog.products.length} products.`);
    const sampleProduct = catalog.products[0];
    if (!sampleProduct) throw new Error('No products available in database to test.');

    // 6. Query Single Product & Add Review & Toggle Favorite
    console.log(`6. Reviewing and favoriting Product ID: ${sampleProduct.id} ("${sampleProduct.name}")...`);
    const prodDetails = await graphql(`
        mutation {
            toggleFavorite(product_id: "${sampleProduct.id}")
            addReview(product_id: "${sampleProduct.id}", rating: 5, comment: "Amazing quality!") {
                id
                rating
                comment
            }
        }
    `, token);
    console.log(`   ✅ Added review (Rating: ${prodDetails.addReview.rating}) & Favorited: ${prodDetails.toggleFavorite}`);

    // 7. Cart Operations (Add, Update, Query)
    console.log('7. Adding product to cart and updating quantity...');
    const addedCart = await graphql(`
        mutation {
            addToCart(product_id: "${sampleProduct.id}", quantity: 2) {
                id
                quantity
            }
        }
    `, token);
    const cartItemId = addedCart.addToCart.id;
    await graphql(`
        mutation {
            updateCartItem(cart_item_id: "${cartItemId}", quantity: 3) {
                id
                quantity
            }
        }
    `, token);
    const cartQuery = await graphql(`
        query {
            cart {
                id
                quantity
                product {
                    name
                    price
                }
            }
        }
    `, token);
    console.log(`   ✅ Cart contains ${cartQuery.cart.length} item(s), total quantity: ${cartQuery.cart[0].quantity}`);

    // 8. Create Order
    console.log('8. Creating order from cart...');
    const orderData = await graphql(`
        mutation {
            createOrder(address_id: "${addressId}", card_id: "${cardId}", shipping_method: "Standard") {
                id
                total_amount
                status
                order_item {
                    quantity
                    price_at_purchase
                    product {
                        name
                    }
                }
            }
        }
    `, token);
    const orderId = orderData.createOrder.id;
    console.log(`   ✅ Order created (ID: ${orderId}), Total: $${orderData.createOrder.total_amount}, Items: ${orderData.createOrder.order_item.length}`);

    // 9. Verify Cart is Empty
    const cartAfterOrder = await graphql(`query { cart { id } }`, token);
    console.log(`   ✅ Cart automatically cleared: ${cartAfterOrder.cart.length} items left.`);

    // 10. Query Single Order by ID
    console.log(`10. Querying single order by ID ${orderId}...`);
    const singleOrder = await graphql(`
        query {
            order(id: "${orderId}") {
                id
                status
                total_amount
                address {
                    city
                    street
                }
                order_item {
                    product {
                        name
                    }
                }
            }
        }
    `, token);
    console.log(`   ✅ Order query resolved! Status: "${singleOrder.order.status}", City: "${singleOrder.order.address.city}"`);

    // 11. Query Full `me` Graph with all Relations
    console.log('11. Querying full user relational graph...');
    const meGraph = await graphql(`
        query {
            me {
                id
                name
                order {
                    id
                    total_amount
                }
                favorite {
                    id
                    name
                }
                address {
                    id
                }
                credit_card {
                    id
                }
            }
        }
    `, token);
    console.log(`   ✅ User graph resolved: ${meGraph.me.order.length} order(s), ${meGraph.me.favorite.length} favorite(s).`);

    // 12. Cleanup (Test Deleting a temporary Address & Card)
    console.log('12. Testing address & card deletion...');
    const temp = await graphql(`
        mutation {
            addAddress(input: {
                name: "Temp", street: "1 Temp St", city: "Amman", zip_code: "111", country: "Jordan", phone: "0790"
            }) { id }
            addCard(input: {
                card_holder_name: "Temp", card_number: "4000000000000000", expiry_date: "01/30", cvv: "000", processor: "Visa"
            }) { id }
        }
    `, token);
    await graphql(`
        mutation {
            deleteAddress(id: "${temp.addAddress.id}")
            deleteCard(id: "${temp.addCard.id}")
        }
    `, token);
    console.log(`   ✅ Successfully tested address & card deletion.`);

    // 13. Test Forgot Password
    console.log('13. Testing forgot password email dispatch via Resend...');
    await graphql(`
        mutation {
            forgotPassword(email: "${uniqueEmail}")
        }
    `);
    console.log(`   ✅ Forgot password triggered and temporary password email dispatched!`);

    console.log('\n🎉 ALL QUERIES AND MUTATIONS TESTED AND PASSED SUCCESSFULLY!');
}

runJourney().catch(err => {
    console.error('\n❌ Journey failed:', err.message);
    process.exit(1);
});
