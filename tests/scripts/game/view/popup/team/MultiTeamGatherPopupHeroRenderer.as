package game.view.popup.team
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.team.MultiTeamGatherPopupHeroValueObject;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   
   public class MultiTeamGatherPopupHeroRenderer extends TeamGatherPopupHeroRenderer
   {
       
      
      private var team_label:MultiTeamGatherTeamLabel;
      
      private var selector:GuiClipNestedContainer;
      
      private var selector_container:LayoutGroup;
      
      public function MultiTeamGatherPopupHeroRenderer()
      {
         team_label = AssetStorage.rsx.popup_theme.grand_team_gather_team_label();
         selector = AssetStorage.rsx.popup_theme.grand_team_gather_hero_selector();
         selector_container = new LayoutGroup();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         team_label.graphics.touchable = false;
         addChild(team_label.graphics);
         addChildAt(selector_container,0);
         selector_container.addChild(selector.graphics);
         selector_container.includeInLayout = false;
      }
      
      override protected function updateState(param1:TeamGatherPopupHeroValueObject) : void
      {
         var _loc2_:MultiTeamGatherPopupHeroValueObject = param1 as MultiTeamGatherPopupHeroValueObject;
         if(!_loc2_)
         {
            return;
         }
         button.isEnabled = _loc2_.isAvailable;
         checkIcon.visible = false;
         selector.graphics.visible = _loc2_ && _loc2_.selected && _loc2_.inCurrentTeam;
         if(_loc2_ && _loc2_.selected || !_loc2_.isAvailable)
         {
            if(_loc2_.inCurrentTeam)
            {
               portrait.disabled = true;
            }
            else
            {
               portrait.disabled = true;
            }
         }
         else
         {
            portrait.disabled = false;
         }
         portrait.visible = _loc2_.isOwned;
         emptySlot.visible = !portrait.visible;
         team_label.graphics.visible = _loc2_ && _loc2_.selected;
         team_label.block_number.text = _loc2_.currentTeamString;
         if(_loc2_ && _loc2_.selected)
         {
            AssetStorage.rsx.popup_theme.setDisabledFilter(team_label.graphics,!_loc2_.inCurrentTeam);
         }
         AssetStorage.rsx.popup_theme.setDisabledFilter(this,_loc2_.blockReason);
      }
   }
}
