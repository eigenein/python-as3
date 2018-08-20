package game.screen.navigator
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.shop.ShopDescription;
   import game.data.storage.shop.StaticSlotsShopDescription;
   import game.mechanics.titan_arena.mediator.TitanArtifactShopPopupMediator;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.shop.ShopPopupMediator;
   import game.mediator.gui.popup.shop.clanwar.ClanWarShopPopupMediator;
   import game.mediator.gui.popup.shop.soul.SoulShopUtils;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopPopupMediator;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopUtils;
   import game.model.user.Player;
   
   public class ShopNavigator extends NavigatorBase
   {
       
      
      public function ShopNavigator(param1:GameNavigator, param2:Player)
      {
         super(param1,param2);
      }
      
      public function navigate(param1:ShopDescription, param2:PopupStashEventParams) : void
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         if(param1.mechanicIdent)
         {
            _loc5_ = DataStorage.mechanic.getByType(param1.mechanicIdent);
         }
         if(param1.ident == SoulShopUtils.shopIdent && !SoulShopUtils.hasHeroesOnMaxStars(player))
         {
            PopupList.instance.message(Translate.translateArgs("UI_DIALOG_SOULSHOP_NOT_AVAILABLE_NO_HEROES",SoulShopUtils.getMinHeroStarRequired()));
            return;
         }
         if(param1.ident == TitanSoulShopUtils.shopIdent && !TitanSoulShopUtils.hasTitansOnMaxStars(player))
         {
            PopupList.instance.message(Translate.translateArgs("UI_DIALOG_TITANSOULSHOP_NOT_AVAILABLE_NO_TITANS",TitanSoulShopUtils.getMinTitanStarRequired()));
            return;
         }
         if(_loc5_ && checkTeamLevel(_loc5_) || !_loc5_ && checkTeamLevel(param1.levelRequirement))
         {
            if(_loc5_ == MechanicStorage.TITAN_ARENA)
            {
               _loc3_ = new TitanArtifactShopPopupMediator(player,param1);
               _loc3_.open(param2);
            }
            else if(_loc5_ == MechanicStorage.CLAN_PVP && param1 is StaticSlotsShopDescription)
            {
               _loc3_ = new ClanWarShopPopupMediator(player,param1 as StaticSlotsShopDescription);
               _loc3_.open(param2);
            }
            else if(param1.ident == TitanSoulShopUtils.shopIdent)
            {
               _loc3_ = new TitanSoulShopPopupMediator(player,param1);
               _loc3_.open(param2);
            }
            else
            {
               _loc4_ = new ShopPopupMediator(player,param1);
               _loc4_.open(param2);
            }
         }
      }
      
      public function isShopAvailable(param1:ShopDescription) : Boolean
      {
         var _loc3_:* = null;
         if(param1.mechanicIdent)
         {
            _loc3_ = DataStorage.mechanic.getByType(param1.mechanicIdent);
         }
         if(_loc3_)
         {
            return navigator.isMechanicEnabled(_loc3_) && player.levelData.level.level >= _loc3_.teamLevel;
         }
         var _loc2_:Boolean = param1.levelRequirement.teamLevel && param1.levelRequirement.teamLevel <= player.levelData.level.level;
         if(_loc2_ && param1.ident == SoulShopUtils.shopIdent)
         {
            return SoulShopUtils.hasHeroesOnMaxStars(player);
         }
         return _loc2_;
      }
   }
}
