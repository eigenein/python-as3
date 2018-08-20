package game.mechanics.dungeon.popup
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.dungeon.mediator.DungeonRulesPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.ClipBasedPopup;
   
   public class DungeonRulesPopup extends ClipBasedPopup
   {
       
      
      private var mediator:DungeonRulesPopupMediator;
      
      private var clip:DungeonRulesPopupClip;
      
      public function DungeonRulesPopup(param1:DungeonRulesPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function close() : void
      {
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(DungeonRulesPopupClip,"dialog_dungeon_rules");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(close);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         var _loc2_:GameScrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (_loc2_.layout as VerticalLayout).horizontalAlign = "center";
         (_loc2_.layout as VerticalLayout).gap = 8;
         _loc2_.width = clip.list_container.graphics.width;
         _loc2_.height = clip.list_container.graphics.height;
         clip.list_container.addChild(_loc2_);
         clip.scroll_content.tf_rules.text = Translate.translate("UI_POPUP_DUNGEON_RULES");
         clip.scroll_content.tf_rules.maxHeight = Infinity;
         clip.scroll_content.tf_rules.height = NaN;
         clip.scroll_content.layout.height = NaN;
         _loc2_.addChild(clip.scroll_content.layout);
      }
   }
}
