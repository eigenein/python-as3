package game.mediator.gui.popup.clan
{
   import game.mediator.gui.popup.clan.info.ClanMemberListValueObject;
   import game.model.user.Player;
   import game.model.user.clan.ClanMemberValueObject;
   
   public class ClanMemberListPrivateValueObject extends ClanMemberListValueObject
   {
       
      
      protected var _canEdit:Boolean;
      
      protected var _canDismiss:Boolean;
      
      public function ClanMemberListPrivateValueObject(param1:ClanMemberValueObject, param2:ClanRole, param3:Player)
      {
         super(param1);
         _canEdit = param2 && param2.permission_edit_admin_rank && param3.id != param1.id;
         var _loc4_:int = 2;
         if(param2 && param2.code == 255)
         {
            _loc4_ = 4;
         }
         _canDismiss = param2 && param2.permission_dismiss_member && param1.clanRole <= _loc4_ && param3.id != param1.id;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function get canEdit() : Boolean
      {
         return _canEdit;
      }
      
      override public function get canDismiss() : Boolean
      {
         return _canDismiss;
      }
   }
}
