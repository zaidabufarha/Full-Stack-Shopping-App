export interface UpdateProfileInput {
    name?: string;
    email?: string;
    phone?: string;
    image_path?: string;
}

export interface UpdateNotificationPreferenceInput {
    allow_general?: boolean;
    allow_order?: boolean;
    allow_email?: boolean;
}

export interface AddressInput {
    name: string;
    street: string;
    city: string;
    state: string;
    zip_code: string;
    country: string;
    phone: string;
    is_default?: boolean;
}

export interface CardInput {
    card_holder_name: string;
    last4?: string;
    card_number?: string;
    expiry_date: string;
    stripe_payment_id?: string;
    processor: string;
    is_default?: boolean;
}

export interface ProductFilterInput {
    category_id?: string;
    search?: string;
    min_rating?: number;
    min_price?: number;
    max_price?: number;
    discount_only?: boolean;
    free_shipping_only?: boolean;
    same_day_delivery_only?: boolean;
    limit?: number;
    offset?: number;
}

export interface OrderInput {
    address_id: string;
    card_id: string;
    shipping_method?: string;
}