/**
 *
 * Starts fetching configs, adhering to the specified minimum fetch interval.
 * @param {number} expirationDuration Minimum fetch interval in seconds
 * @returns {Promise<void>} Callback when operation is completed
 *
 * @example
 * cordova.plugins.firebase.config.fetch(8 * 3600);
 */
export function fetch(expirationDuration: number): Promise<void>;
/**
 *
 * Asynchronously activates the most recently fetched configs, so that the fetched key value pairs take effect.
 * @returns {Promise<boolean>} Fulfills promise with flag if current config was activated
 *
 * @example
 * cordova.plugins.firebase.config.activate();
 */
export function activate(): Promise<boolean>;
/**
 *
 * Asynchronously fetches and then activates the fetched configs.
 * @returns {Promise<boolean>} Fulfills promise with flag if current config was activated
 *
 * @example
 * cordova.plugins.firebase.config.fetchAndActivate();
 */
export function fetchAndActivate(): Promise<boolean>;
/**
 *
 * Returns the boolean parameter value for the given key
 * @param {string} key Parameter key
 * @returns {Promise<boolean>} Fulfills promise with parameter value
 *
 * @example
 * cordova.plugins.firebase.config.getBoolean("myBool").then(function(value) {
 *     // use value from remote config
 * });
 */
export function getBoolean(key: string): Promise<boolean>;
/**
 *
 * Returns the string parameter value for the given key
 * @param {string} key Parameter key
 * @returns {Promise<string>} Fulfills promise with parameter value
 *
 * @example
 * cordova.plugins.firebase.config.getString("myStr").then(function(value) {
 *     // use value from remote config
 * });
 */
export function getString(key: string): Promise<string>;
/**
 *
 * Returns the number parameter value for the given key
 * @param {string} key Parameter key
 * @returns {Promise<number>} Fulfills promise with parameter value
 *
 * @example
 * cordova.plugins.firebase.config.getNumber("myNumber").then(function(value) {
 *     // use value from remote config
 * });
 */
export function getNumber(key: string): Promise<number>;
/**
 *
 * Returns the bytes parameter value for the given key
 * @param {string} key Parameter key
 * @returns {Promise<ArrayBuffer>} Fulfills promise with parameter value
 *
 * @example
 * cordova.plugins.firebase.config.getBytes("myByteArray").then(function(value) {
 *     // use value from remote config
 * });
 */
export function getBytes(key: string): Promise<ArrayBuffer>;
/**
 *
 * Returns source of the value for the specified key.
 * @param {string} key Parameter key
 * @returns {Promise<number>} Fulfills promise with parameter value
 *
 * @example
 * cordova.plugins.firebase.config.getValueSource("myArbitraryValue").then(function(source) {
 *     if (source === cordova.plugins.firebase.config.VALUE_SOURCE_DEFAULT) {
 *         // ...
 *     }
 * });
 */
export function getValueSource(key: string): Promise<number>;
/**
 * Indicates that the value returned is the static default value.
 * @type {number}
 * @constant
 */
export var VALUE_SOURCE_STATIC: number;
/**
 * Indicates that the value returned was retrieved from the defaults set by the client.
 * @type {number}
 * @constant
 */
export var VALUE_SOURCE_DEFAULT: number;
/**
 * Indicates that the value returned was retrieved from the Firebase Remote Config Server.
 * @type {number}
 * @constant
 */
export var VALUE_SOURCE_REMOTE: number;
