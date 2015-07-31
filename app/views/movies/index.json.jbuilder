json.array!(@movies) do |movie|
  json.extract! movie, :id, :poster, :title, :upvotes, :downvotes
  json.url movie_url(movie, format: :json)
end
