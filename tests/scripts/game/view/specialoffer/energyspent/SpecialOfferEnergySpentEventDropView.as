package game.view.specialoffer.energyspent
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.model.user.specialoffer.PlayerSpecialOfferEnergySpentEventDrop;
   
   public class SpecialOfferEnergySpentEventDropView extends GuiClipNestedContainer
   {
       
      
      private var timerClip:SpecialOfferEnergySpentTimerClip;
      
      private var data:PlayerSpecialOfferEnergySpentEventDrop;
      
      public function SpecialOfferEnergySpentEventDropView(param1:PlayerSpecialOfferEnergySpentEventDrop)
      {
         super();
         timerClip = new SpecialOfferEnergySpentTimerClip();
         timerClip.tf_desc.text = Translate.translate("UI_SPECIALOFFER_UNIQUE_EVENT_DROP");
         _container.addChild(timerClip.graphics);
         setData(param1);
      }
      
      public function dispose() : void
      {
         setData(null);
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         graphics.dispose();
      }
      
      public function setData(param1:PlayerSpecialOfferEnergySpentEventDrop) : void
      {
         if(this.data)
         {
            this.data.signal_updated.remove(handler_updateProgress);
            this.data.signal_removed.remove(handler_removed);
         }
         this.data = param1;
         if(param1)
         {
            param1.signal_updated.add(handler_updateProgress);
            param1.signal_removed.add(handler_removed);
            handler_updateProgress();
         }
      }
      
      private function handler_updateProgress() : void
      {
         timerClip.tf_timer.text = data.timerString;
      }
      
      private function handler_removed() : void
      {
         dispose();
      }
   }
}
