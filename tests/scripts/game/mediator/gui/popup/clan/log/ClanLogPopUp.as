package game.mediator.gui.popup.clan.log
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.arena.log.ArenaLogPopupClip;
   
   public class ClanLogPopUp extends ClipBasedPopup
   {
       
      
      private var mediator:ClanLogPopUpMediator;
      
      private var clip:ArenaLogPopupClip;
      
      private var logContainer:LayoutGroup;
      
      private var scrollContainer:GameScrollContainer;
      
      public function ClanLogPopUp(param1:ClanLogPopUpMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_arena_log();
         addChild(clip.graphics);
         clip.title = Translate.translate("UI_DIALOG_CLAN_LOGS");
         logContainer = new LayoutGroup();
         logContainer.layout = new VerticalLayout();
         (logContainer.layout as VerticalLayout).gap = 0;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         scrollContainer = new GameScrollContainer(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         (scrollContainer.layout as VerticalLayout).paddingTop = 15;
         (scrollContainer.layout as VerticalLayout).paddingBottom = 15;
         scrollContainer.width = clip.list_container.graphics.width;
         scrollContainer.height = clip.list_container.graphics.height;
         scrollContainer.addChild(logContainer);
         clip.list_container.container.addChild(scrollContainer);
         clip.tf_message.visible = false;
         clip.button_close.signal_click.add(mediator.close);
         mediator.signal_update.add(handler_logUpdate);
         mediator.action_refreshLog();
      }
      
      private function handler_logUpdate() : void
      {
         var _loc10_:* = null;
         var _loc7_:int = 0;
         var _loc12_:* = null;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc11_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         logContainer.removeChildren();
         var _loc3_:Array = mediator.datesTexts;
         var _loc5_:Array = mediator.logTexts;
         _loc7_ = 0;
         while(_loc7_ < _loc3_.length)
         {
            _loc10_ = GameLabel.special24();
            _loc10_.width = clip.list_container.container.width - 20;
            _loc10_.wordWrap = true;
            _loc10_.text = _loc3_[_loc7_];
            logContainer.addChild(_loc10_);
            if(_loc5_[_loc7_])
            {
               _loc12_ = _loc5_[_loc7_];
               _loc1_ = [];
               _loc4_ = 0;
               _loc6_ = 10000;
               _loc11_ = "\n";
               _loc8_ = _loc12_.indexOf(_loc11_,_loc4_ + _loc6_);
               while(_loc8_ > 0)
               {
                  _loc1_.push(_loc12_.substring(_loc4_,_loc8_));
                  _loc4_ = _loc8_ + _loc11_.length;
                  _loc8_ = _loc12_.indexOf(_loc11_,_loc4_ + _loc6_);
               }
               _loc1_.push(_loc12_.substring(_loc4_,_loc12_.length));
               _loc9_ = 0;
               while(_loc9_ < _loc1_.length)
               {
                  _loc10_ = GameLabel.special16();
                  _loc10_.width = clip.list_container.container.width - 20;
                  _loc10_.wordWrap = true;
                  _loc10_.text = _loc1_[_loc9_];
                  logContainer.addChild(_loc10_);
                  _loc9_++;
               }
            }
            _loc7_++;
         }
         logContainer.validate();
         var _loc2_:Number = Math.max(0,logContainer.height - scrollContainer.viewPort.visibleHeight + (scrollContainer.layout as VerticalLayout).paddingTop + (scrollContainer.layout as VerticalLayout).paddingBottom);
         scrollContainer.scrollToPosition(NaN,_loc2_,0);
         clip.tf_message.visible = _loc5_ == null;
      }
   }
}
