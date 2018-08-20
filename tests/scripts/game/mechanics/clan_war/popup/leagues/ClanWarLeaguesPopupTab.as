package game.mechanics.clan_war.popup.leagues
{
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.view.popup.common.PopupSideCompositeTab;
   import game.view.popup.common.PopupSideTab;
   import starling.filters.ColorMatrixFilter;
   
   public class ClanWarLeaguesPopupTab extends PopupSideCompositeTab
   {
       
      
      public function ClanWarLeaguesPopupTab()
      {
         super();
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
            buttonContainer.filter = _loc3_;
         }
         else if(buttonContainer.filter)
         {
            buttonContainer.filter.dispose();
            buttonContainer.filter = null;
         }
         if(param2 && param1 == "down")
         {
            playClickSound();
         }
      }
      
      override protected function createSubTabButton(param1:*) : PopupSideTab
      {
         var _loc2_:PopupSideTab = AssetStorage.rsx.popup_theme.create(PopupSideTab,"dialog_side_sub_tab");
         _loc2_.label = (param1 as ClanWarLeagueDescription).name;
         return _loc2_;
      }
   }
}
