const actioncableConfig = {
  debug: true,
  debugLevel: "error",
  connectionUrl: process.env.VUE_APP_BASE_CABLE_URL,
  connectImmediately: true,
}
export default actioncableConfig