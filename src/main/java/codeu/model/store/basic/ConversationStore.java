// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.store.basic;

import codeu.model.data.Conversation;
import codeu.model.data.User;
import codeu.model.store.basic.ConversationStore;
import codeu.model.store.basic.UserStore;
import codeu.model.store.persistence.PersistentStorageAgent;
import java.io.IOException;
import java.time.Instant;
import java.util.List;
import java.util.ArrayList;
import java.util.UUID;

/**
 * Store class that uses in-memory data structures to hold values and automatically loads from and
 * saves to PersistentStorageAgent. It's a singleton so all servlet classes can access the same
 * instance.
 */
public class ConversationStore {

  /** Singleton instance of ConversationStore. */
  private static ConversationStore instance;

  /**
   * Returns the singleton instance of ConversationStore that should be shared between all servlet
   * classes. Do not call this function from a test; use getTestInstance() instead.
   */
  public static ConversationStore getInstance() {
    if (instance == null) {
      instance = new ConversationStore(PersistentStorageAgent.getInstance());
    }
    return instance;
  }

  /**
   * Instance getter function used for testing. Supply a mock for PersistentStorageAgent.
   *
   * @param persistentStorageAgent a mock used for testing
   */
  public static ConversationStore getTestInstance(PersistentStorageAgent persistentStorageAgent) {
    return new ConversationStore(persistentStorageAgent);
  }

  /**
   * The PersistentStorageAgent responsible for loading Conversations from and saving Conversations
   * to Datastore.
   */
  private PersistentStorageAgent persistentStorageAgent;

  /** The in-memory list of Conversations. */
  private List<Conversation> conversations;
  private List<Conversation> userconversations;

  /** This class is a singleton, so its constructor is private. Call getInstance() instead. */
  private ConversationStore(PersistentStorageAgent persistentStorageAgent) {
    this.persistentStorageAgent = persistentStorageAgent;
    conversations = new ArrayList<>();
    userconversations = new ArrayList<>();
  }

/** Access the current set of conversations known to the application. */
  public List<Conversation> getAllConversations() {
    return conversations;
  }
  
  public List<Conversation> getUserConversations(User user) {
    UUID userId = user.getId();
    for (Conversation conversation : conversations) {
      if (conversation.getContributorList().contains(userId)) {
        userconversations.add(conversation);
      }
    }
    return userconversations;
  }
  
  public Boolean userHasConversations(UUID userId) {
    for (Conversation conversation : conversations) {
      if (conversation.getContributorList().contains(userId)) {
        userconversations.add(conversation);
      }
    }
    if (userconversations != null) {
      return true;
    }
    else {
      return false;
    }
  }
  
  /** Add a new conversation to the current set of conversations known to the application. */
  public void addConversation(Conversation conversation) {
    conversations.add(conversation);
    persistentStorageAgent.writeThrough(conversation);
  }
  
  public void addUserConversation(Conversation conversation) {
    userconversations.add(conversation);
    persistentStorageAgent.writeThrough(conversation);    
  }
  
  /** Check whether a Conversation title is already known to the application. */
  public boolean isTitleTaken(String title) {
    // This approach will be pretty slow if we have many Conversations.
    for (Conversation conversation : conversations) {
      if (conversation.getTitle().equals(title)) {
        return true;
      }
    }
    return false;
  }

  /** Find and return the Conversation with the given title. */
  public Conversation getConversationWithTitle(String title) {
    for (Conversation conversation : conversations) {
      if (conversation.getTitle().equals(title)) {
        return conversation;
      }
    }
    return null;
  }

  /** Sets the List of Conversations stored by this ConversationStore. */
  public void setConversations(List<Conversation> conversations) {
    this.conversations = conversations;
  }
  
  public void setUserConversations(List<Conversation> userconversations) {
    this.userconversations = userconversations;
  }
}
