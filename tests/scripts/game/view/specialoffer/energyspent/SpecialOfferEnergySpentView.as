package game.view.specialoffer.energyspent
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.model.user.specialoffer.PlayerSpecialOfferEnergySpent;
   
   public class SpecialOfferEnergySpentView extends GuiClipNestedContainer
   {
       
      
      private var limitClip:SpecialOfferEnergySpentLimitClip;
      
      private var timerClip:SpecialOfferEnergySpentTimerClip;
      
      private var data:PlayerSpecialOfferEnergySpent;
      
      public function SpecialOfferEnergySpentView(param1:PlayerSpecialOfferEnergySpent)
      {
         super();
         _container.touchable = false;
         if(param1.hasEndTime)
         {
            timerClip = new SpecialOfferEnergySpentTimerClip();
            timerClip.tf_header.text = param1.localeTitle;
            timerClip.tf_desc.text = param1.localeDesc;
            timerClip.tf_till_over.text = param1.localeTimer;
            _container.addChild(timerClip.graphics);
         }
         else
         {
            limitClip = new SpecialOfferEnergySpentLimitClip();
            limitClip.tf_header.text = param1.localeTitle;
            limitClip.tf_desc.text = param1.localeDesc;
            _container.addChild(limitClip.graphics);
         }
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
      
      public function setData(param1:PlayerSpecialOfferEnergySpent) : void
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
         if(data.hasEndTime)
         {
            timerClip.tf_timer.text = data.timerString;
         }
         else
         {
            limitClip.tf_progress.text = data.progressString;
         }
      }
      
      private function handler_removed() : void
      {
         dispose();
      }
   }
}
