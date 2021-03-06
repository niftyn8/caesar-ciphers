defmodule Caesar do
  def encipher(string, key) do
    case key do
      { m, s } ->
        if :lists.member(m, valid_primes) do
          cipher(string, cipher_func(m, s))
        else
          raise InvalidKey, "First element in key must be a valid prime below 127!"
        end
      s when is_number(s) ->
        cipher(string, weak_cipher_func(key))
      _ ->
        raise InvalidKey
    end
  end

  def decipher(string, key) do
    cipher(string, weak_cipher_func(-key))
  end

  def cipher(string, func) do
    string |> String.downcase
           |> String.to_char_list
           |> Enum.map(func)
           |> List.to_string
  end

  def weak_cipher_func(key) do
    fn(c) -> rem(c + key, 127) end
  end

  def cipher_func(m, s) do
    fn(c) -> rem((c * m + s), 127) end
  end

  def valid_primes do
    [
     2, 3, 5, 7, 11, 13, 17, 19, 23, 29,
     31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
     73, 79, 83, 89, 97, 101, 103, 107, 109, 113
    ]
  end
end

defmodule InvalidKey do
  defexception [message: "Invalid cipher key!"]

  def exception(msg) do
    %InvalidKey{message: msg}
  end
end
