package game.mediator.gui.popup.clan
{
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.level.ClanLevel;
   import game.model.user.Player;
   import game.model.user.clan.ClanMemberValueObject;
   
   public class ClanValueObject
   {
       
      
      private var player:Player;
      
      private var data:ClanPublicInfoValueObject;
      
      private var _playerCanJoin:Boolean;
      
      public function ClanValueObject(param1:ClanPublicInfoValueObject, param2:Player)
      {
         super();
         this.data = param1;
         _playerCanJoin = param2.levelData.level.level >= param1.minLevel;
         this.player = param2;
      }
      
      public function get members() : Vector.<ClanMemberValueObject>
      {
         return data.members;
      }
      
      public function get id() : int
      {
         return data.id;
      }
      
      public function get topActivity() : int
      {
         return data.topActivity;
      }
      
      public function get membersCount() : int
      {
         return data.membersCount;
      }
      
      public function get title() : String
      {
         return data.title;
      }
      
      public function get minLevel() : int
      {
         return data.minLevel;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return data.icon;
      }
      
      public function get maxMembersCount() : int
      {
         var _loc1_:ClanLevel = DataStorage.level.getClanLevel(1);
         return _loc1_.maxPlayersCount;
      }
      
      public function get playerCanJoin() : Boolean
      {
         return _playerCanJoin;
      }
   }
}
