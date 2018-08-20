package game.view.popup.fightresult.pvp
{
   import game.assets.storage.AssetStorage;
   import game.view.popup.fightresult.RewardDialogHeroItemRendererBase;
   
   public class ArenaVictoryPopupHeroItemRenderer extends RewardDialogHeroItemRendererBase
   {
       
      
      public function ArenaVictoryPopupHeroItemRenderer()
      {
         super();
      }
      
      override protected function createPanelClip() : void
      {
         panel_clip = AssetStorage.rsx.popup_theme.create_hero_list_panel_pvp();
         addChild(panel_clip.graphics);
      }
   }
}
