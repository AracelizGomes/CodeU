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
import java.util.UUID;
<<<<<<< HEAD
import java.time.LocalDateTime;
import java.time.ZoneId;
=======
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

>>>>>>> dd0cb40922c61cf38f533c730cba44f1cbe6659a
/** Class representing a message. Messages are sent by a User in a Conversation. */
public class Message {

  private final UUID id;
  private final UUID conversation;
  private final UUID author;
  private final String noHtmlContent;
  private final Instant creation;
  private final String contentWithHtml;

  /**
   * Constructs a new Message.
   *
   * @param id the ID of this Message
   * @param conversation the ID of the Conversation this Message belongs to
   * @param author the ID of the User who sent this Message
   * @param content the text content of this Message
   * @param creation the creation time of this Message
   */
  public Message(UUID id, UUID conversation, UUID author, String content, Instant creation) {
    this.id = id;
    this.conversation = conversation;
    this.contentWithHtml = content;
    this.author = author;
    //get rid of all html tags
    this.noHtmlContent = Jsoup.clean(content, Whitelist.none());
    this.creation = creation;
  }

  /** Returns the ID of this Message. */
  public UUID getId() {
    return id;
  }

  /** Returns the ID of the Conversation this Message belongs to. */
  public UUID getConversationId() {
    return conversation;
  }

  /** Returns the ID of the User who sent this Message. */
  public UUID getAuthorId() {
    return author;
  }

  /** Returns the text content of this Message. */
  public String getContent() {
    return noHtmlContent;
  }

  public String getContentWithHtml() {
    return contentWithHtml;
  }

  /** Returns the creation time of this Message. */
  public Instant getCreationTime() {
    return creation;
  }


  /** Time display */ 
  public String getTime() {
    LocalDateTime localDate = LocalDateTime.ofInstant(creation, ZoneId.systemDefault());
    int hr = localDate.getHour();
    Boolean AM=true;
    if (hr > 12) {
      hr = hr % 12;
      AM = false;
    }
    String Date = localDate.getMonth().toString() + " " + localDate.getDayOfMonth() + ", " + localDate.getYear() + " ~ " + hr + ":" + localDate.getMinute() + " " + (AM ? "AM":"PM");
    return Date;
  }
} 