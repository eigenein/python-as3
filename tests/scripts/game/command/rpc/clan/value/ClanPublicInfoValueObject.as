package game.command.rpc.clan.value
{
   import game.model.user.clan.ClanBasicInfoValueObject;
   import game.model.user.clan.ClanMemberValueObject;
   
   public class ClanPublicInfoValueObject extends ClanBasicInfoValueObject
   {
       
      
      protected var _playerCanJoin:Boolean;
      
      public function ClanPublicInfoValueObject(param1:Object)
      {
         var _loc3_:* = null;
         super(param1.clan);
         var _loc5_:int = 0;
         var _loc4_:* = param1.clan.members;
         for each(var _loc2_ in param1.clan.members)
         {
            _loc3_ = new ClanMemberValueObject(this,_loc2_);
            _members.push(_loc3_);
         }
         parseMemberStat(param1);
      }
      
      public function get playerCanJoin() : Boolean
      {
         return _playerCanJoin;
      }
   }
}
