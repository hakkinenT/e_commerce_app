const baseUrl = 'http://192.168.1.3:3000';
const productCatalogUrl = '$baseUrl/444/products';

// input validators messages

const emptyFailureMessage = "Este campo é obrigatório";
const startWithUnderscoreFailureMessage =
    "Este campo não pode comerçar com o undescore (_)";
const startWithNumberFailureMessage = "Este campo não pode começar com números";
const invalidEmailFailureMessage = "E-mail inválido";
const passwordLengthFailureMessage = "A senha deve ter no mínimo 8 caracteres";
const passwordHasNotLetterFailureMessage = "A senha deve conter letras";
const passwordHasNotNumberFailureMessage = "A senha deve conter números";

// Cache failure error message
const String cacheFailureErrorMessage = 'Cache Failure';
