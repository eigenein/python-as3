package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.view.IDisposable;
   import game.view.gui.components.ClipLabel;
   
   public class NYSendGiftContent extends GuiClipNestedContainer implements IDisposable
   {
       
      
      private var _mediator:NYGiftsPopupMediator;
      
      public var tf_title:ClipLabel;
      
      public var tf_results:ClipLabel;
      
      public var gift_:Vector.<NYGiftItemRenderer>;
      
      public var hero_1:NYGiftHeroRenderer;
      
      public var hero_2:NYGiftHeroRenderer;
      
      public function NYSendGiftContent()
      {
         tf_title = new ClipLabel();
         tf_results = new ClipLabel();
         gift_ = new Vector.<NYGiftItemRenderer>();
         hero_1 = new NYGiftHeroRenderer();
         hero_2 = new NYGiftHeroRenderer();
         super();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < gift_.length)
         {
            gift_[_loc1_].dispose();
            _loc1_++;
         }
      }
      
      public function get mediator() : NYGiftsPopupMediator
      {
         return _mediator;
      }
      
      public function set mediator(param1:NYGiftsPopupMediator) : void
      {
         if(_mediator == param1)
         {
            return;
         }
         _mediator = param1;
         update();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_title.text = Translate.translate("UI_DIALOG_NY_GIFTS_TITLE");
         tf_results.text = Translate.translate("UI_DIALOG_NY_GIFTS_RESULT");
         hero_1.signal_click.add(handler_hero_1_click);
         hero_2.signal_click.add(handler_hero_2_click);
      }
      
      private function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<NYGiftDescription> = mediator.sortedGiftsList;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            gift_[_loc1_].mediator = mediator;
            gift_[_loc1_].setData(_loc2_[_loc1_]);
            _loc1_++;
         }
         hero_1.setData(mediator.eventHero,Translate.translate("UI_DIALOG_NY_GIFTS_EVENT_HERO_DESC"));
         hero_2.setData(mediator.dayHero,Translate.translate("UI_DIALOG_NY_GIFTS_DAY_HERO_DESC"));
      }
      
      private function handler_hero_1_click() : void
      {
         mediator.action_openHeroPopup(mediator.eventHero);
      }
      
      private function handler_hero_2_click() : void
      {
         mediator.action_openHeroPopup(mediator.dayHero);
      }
   }
}
