class Mutations::UpdateBook < Mutations::BaseMutation
  null true

  argument :id, ID, required: true
  argument :author_id, ID, required: true
  argument :title, String, required: false
  argument :genre, String, required: false

  field :book, BookType, null: true
  field :errors, [String], null: false

  def resolve(id:, author_id:, title:, genre:)
    book = Book.find_by_id(id)

    if book
      if book.author_id == author_id.to_i
        book.update(title: title, genre: genre)
        {
          book: book,
          errors: []
        }
      else
        GraphQL::ExecutionError.new('You cannot make changes to this book')
      end
    else
      GraphQL::ExecutionError.new('The book you are searching for does not exist')
    end
  end
end