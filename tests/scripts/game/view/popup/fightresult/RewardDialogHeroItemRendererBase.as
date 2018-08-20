package game.view.popup.fightresult
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.view.gui.components.HeroPortrait;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class RewardDialogHeroItemRendererBase extends ListItemRenderer
   {
       
      
      protected var portrait:HeroPortrait;
      
      protected var panel_clip:RewardDialogHeroPanelBase;
      
      protected var bg:ClipSprite;
      
      public function RewardDialogHeroItemRendererBase()
      {
         super();
      }
      
      protected function createPanelClip() : void
      {
         panel_clip = AssetStorage.rsx.popup_theme.create_hero_list_panel();
         addChild(panel_clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createPanelClip();
         portrait = new HeroPortrait();
         panel_clip.hero_portrait.container.addChild(portrait);
      }
      
      override protected function commitData() : void
      {
         var _loc1_:UnitEntryValueObject = data as UnitEntryValueObject;
         if(_loc1_)
         {
            portrait.data = _loc1_;
            panel_clip.tf_hero_name.text = _loc1_.name;
            if(bg)
            {
               if(bg.graphics.parent)
               {
                  bg.graphics.parent.removeChild(bg.graphics);
               }
               bg = null;
            }
            if(data is TitanEntryValueObject)
            {
               bg = AssetStorage.rsx.battle_interface.create(ClipSprite,"titan_portrait_panel_bg");
               bg.graphics.y = 1;
            }
            else
            {
               bg = AssetStorage.rsx.battle_interface.create(ClipSprite,"hero_portrait_panel_bg");
            }
            panel_clip.heroBrownBG_inst0.container.addChild(bg.graphics);
         }
      }
   }
}
