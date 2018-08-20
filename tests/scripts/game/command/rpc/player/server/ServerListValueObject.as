package game.command.rpc.player.server
{
   import com.progrestar.common.lang.Translate;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class ServerListValueObject
   {
       
      
      public var user:ServerListUserValueObject;
      
      public var friends:Vector.<PlayerFriendEntry>;
      
      private var _id:int;
      
      private var _user_count:int;
      
      private var _name:String;
      
      public function ServerListValueObject(param1:Object)
      {
         friends = new Vector.<PlayerFriendEntry>();
         super();
         _id = param1.id;
         _user_count = param1.user_count;
         _name = Translate.translate("LIB_SERVER_NAME_" + _id);
      }
      
      public function get friendCount() : int
      {
         return !!friends?friends.length:0;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get user_count() : int
      {
         return _user_count;
      }
      
      public function get nickname() : String
      {
         return !!user?user.nickname:"";
      }
      
      public function get level() : String
      {
         return !!user?user.level.toString():"";
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}
