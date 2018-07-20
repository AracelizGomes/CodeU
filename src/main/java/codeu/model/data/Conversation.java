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

package codeu.model.data;

import java.time.Instant;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.UUID;


/**
 * Class representing a conversation, which can be thought of as a chat room. Conversations are
 * created by a User and contain Messages.
 */
public class Conversation {
  private final UUID id;
  private final UUID owner;
  private final Instant creation;
  private final String title;
  private final HashSet<UUID> contributorList;

  /**
   * Constructs a new Conversation.
   *
   * @param id the ID of this Conversation
   * @param owner the ID of the User who created this Conversation
   * @param title the title of this Conversation
   * @param creation the creation time of this Conversation
   * @param contributorList the contributorList of this Conversation
   */
  public Conversation(UUID id, UUID owner, String title, HashSet<UUID> contributorList, Instant creation) {
    this.id = id;
    this.owner = owner;
    this.creation = creation;
    this.title = title;
    this.contributorList = contributorList;
  }

  /** Returns the ID of this Conversation. */
  public UUID getId() {
    return id;
  }

  /** Returns the ID of the User who created this Conversation. */
  public UUID getOwnerId() {
    return owner;
  }

  /** Returns the title of this Conversation. */
  public String getTitle() {
    return title;
  }
  
  public void addUser(User newUser) {
    UUID newId = newUser.getId();
    contributorList.add(newId);
  }
  
  public void deleteUser(User user) {
    boolean deleted = contributorList.remove(user);
    System.out.println(deleted);
    System.out.println("User was removed from conversation");
  }
  
  public boolean isContributor(User user1) {
    UUID id1 = user1.getId();
    
    System.out.println(contributorList + " - contributorList");
    System.out.println(id1 + " - id1");
    if(contributorList.contains(id1)) {
      System.out.println("true");
      return true;
    }
    System.out.println(contributorList + " - contributorList");
    System.out.println(id1 + " - id1");
    System.out.println("false");
    return false;
  }
  
  /** Returns the list of users that have access to this Conversation. */
  public HashSet<UUID> getContributorList() {
    return contributorList;
  }

  /** Returns the creation time of this Conversation. */
  public Instant getCreationTime() {
    return creation;
  }
  /** Time display */ 
  public String getTime() {
    LocalDateTime localDate = LocalDateTime.ofInstant(creation, ZoneId.systemDefault());
    int hr = localDate.getHour();
    Boolean AM = true;
    if (hr > 12) {
      hr = hr % 12;
      AM = false;
    }
    return localDate.getMonth().toString() + " " + localDate.getDayOfMonth() + ", " + localDate.getYear() + " ~ " + hr + ":" + localDate.getMinute() + " " + (AM ? "AM" : "PM");
  }
}
