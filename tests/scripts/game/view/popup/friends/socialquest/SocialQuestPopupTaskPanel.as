package game.view.popup.friends.socialquest
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.friends.socialquest.SocialQuestTaskValueObject;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class SocialQuestPopupTaskPanel extends GuiClipNestedContainer
   {
       
      
      private var data:SocialQuestTaskValueObject;
      
      public var button_go:ClipButtonLabeled;
      
      public var tf_task:ClipLabel;
      
      public var tf_task_complete:ClipLabel;
      
      public var tf_task_desc:ClipLabel;
      
      public var tf_task_progress:ClipLabel;
      
      public var task_check:ClipSprite;
      
      public var bg:GuiClipScale9Image;
      
      public var bg2:GuiClipScale9Image;
      
      public function SocialQuestPopupTaskPanel()
      {
         button_go = new ClipButtonLabeled();
         tf_task = new ClipLabel();
         tf_task_complete = new ClipLabel();
         tf_task_desc = new ClipLabel();
         tf_task_progress = new ClipLabel();
         task_check = new ClipSprite();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         bg2 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function setData(param1:SocialQuestTaskValueObject) : void
      {
         if(!param1)
         {
            return;
            §§push(this.data && this.data.signal_update.remove(handler_dataUpdate));
         }
         else
         {
            this.data = param1;
            param1.signal_update.add(handler_dataUpdate);
            button_go.label = param1.buttonLabel;
            tf_task.text = param1.title;
            tf_task_complete.text = param1.title;
            tf_task_desc.text = param1.desc;
            if(param1.progressMax > 1)
            {
               tf_task_progress.text = param1.progress + "/" + param1.progressMax;
            }
            else
            {
               tf_task_progress.visible = false;
            }
            button_go.signal_click.add(handler_click);
            update();
            return;
         }
      }
      
      protected function update() : void
      {
         if(data.progressMax > 1)
         {
            tf_task_progress.text = data.progress + "/" + data.progressMax;
         }
         tf_task_complete.visible = data.complete;
         tf_task.visible = !data.complete;
         task_check.graphics.visible = data.complete;
         button_go.graphics.visible = !data.complete;
      }
      
      private function handler_dataUpdate() : void
      {
         update();
      }
      
      private function handler_click() : void
      {
         data.dispatchAction();
      }
   }
}
