class Mutations::DeleteBook < Mutations::BaseMutation
  null true

  argument :id, ID, required: true
  argument :authorId, ID, required: true

  field :book, BookType, null: true
  field :errors, [String], null: false

  def resolve(id:, authorId:)
    book = Book.find_by_id(id)

    if book
      if book.author_id == author_id.to_i
        book.destroy
        {
          book: book,
          errors: []
        }
      else
        GraphQL::ExecutionError.new('You cannot delete this book')
      end
    else
      GraphQL::ExecutionError.new('The book you are searching for does not exist')
    end
  end
end