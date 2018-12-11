import gql from 'graphql-tag';

export default gql`
  {
    authors {
      id
      name
      books {
        id
      }
    }
  }
`;