package game.data.storage.clan
{
   import game.data.storage.DescriptionStorage;
   import game.mediator.gui.popup.clan.ClanRole;
   
   public class ClanRoleStorage extends DescriptionStorage
   {
       
      
      public function ClanRoleStorage()
      {
         super();
      }
      
      public function getByCode(param1:int) : ClanRole
      {
         return _items[param1];
      }
      
      override protected function parseItem(param1:Object) : void
      {
         var _loc2_:ClanRole = new ClanRole(param1);
         _items[_loc2_.code] = _loc2_;
      }
   }
}
