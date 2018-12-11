import React, { Component } from 'react'
import {
  Card, 
  Button,
  Header
} from 'semantic-ui-react';
import { Link } from 'react-router-dom';
import { Mutation } from 'react-apollo';

import deleteAuthor from '../mutations/deleteAuthor';
import query from '../queries/getAuthors';

class AuthorCard extends Component {
  deleteAuthor = (deleteAuthor) => {
    deleteAuthor({ variables: { id: this.props.author.id }, refetchQueries: [{ query }] })
  }

  render() {
    const { name, id, books } = this.props.author;
    return (
      <Card>
        <Card.Content>
          <Card.Header as={Link} to={`/authors/${id}`}>{name}</Card.Header>
          <Header as='p'>No of books: {books.length}</Header>
        </Card.Content>
        <Card.Content extra>
          <Mutation mutation={deleteAuthor}>
            {(deleteAuthor, { data }) => (
              <Button color='red' onClick={() => this.deleteAuthor(deleteAuthor)}>Delete</Button>
            )}
          </Mutation>
        </Card.Content>
      </Card>
    )
  }
}

export default AuthorCard;