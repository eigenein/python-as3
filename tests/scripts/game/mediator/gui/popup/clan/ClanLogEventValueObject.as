package game.mediator.gui.popup.clan
{
   public class ClanLogEventValueObject
   {
      
      public static const JOIN:String = "join";
      
      public static const LEAVE:String = "leave";
      
      public static const KICK:String = "kick";
      
      public static const RENAME:String = "rename";
      
      public static const CHANGE:String = "change";
      
      public static const CREATE:String = "create";
      
      public static const NEW_LEADER:String = "newLeader";
      
      public static const POINTS:String = "points";
      
      public static const DUNGEON_POINTS:String = "dungeonPoints";
      
      public static const BLACKLIST_ADD:String = "blackListAdd";
      
      public static const BLACKLIST_REMOVE:String = "blackListRemove";
       
      
      public var id:int;
      
      public var clanId:int;
      
      public var userId:int;
      
      public var event:String;
      
      public var details:Object;
      
      public var ctime:int;
      
      public function ClanLogEventValueObject()
      {
         super();
      }
      
      public function deserialize(param1:Object) : void
      {
         this.id = param1.id;
         this.clanId = param1.clanId;
         this.userId = param1.userId;
         this.event = param1.event;
         this.details = param1.details;
         this.ctime = param1.ctime;
      }
   }
}
