"use client";

import { ApolloLink, HttpLink } from "@apollo/client";
import {
  ApolloNextAppProvider,
  NextSSRInMemoryCache,
  NextSSRApolloClient,
  SSRMultipartLink,
} from "@apollo/experimental-nextjs-app-support/ssr";
import React from "react";

const makeClient = (graphqlEndpointUri: string) => {
  const httpLink = new HttpLink({
    uri: graphqlEndpointUri,
    fetchOptions: { cache: "no-store" },
  });

  return new NextSSRApolloClient({
    cache: new NextSSRInMemoryCache(),
    link:
      typeof window === "undefined"
        ? ApolloLink.from([
            new SSRMultipartLink({
              stripDefer: true,
            }),
            httpLink,
          ])
        : httpLink,
  });
}

type ApolloWrapperType = React.PropsWithChildren<{
  graphqlEndpointUri: string;
}>

const ApolloWrapper = ({ children, graphqlEndpointUri }: ApolloWrapperType) => {
  const client = () => makeClient(graphqlEndpointUri)

  return (
    <ApolloNextAppProvider makeClient={client}>
      {children}
    </ApolloNextAppProvider>
  );
}

export {ApolloWrapper}
