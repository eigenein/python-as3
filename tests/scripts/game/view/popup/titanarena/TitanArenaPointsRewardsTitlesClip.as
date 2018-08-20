package game.view.popup.titanarena
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class TitanArenaPointsRewardsTitlesClip extends GuiClipNestedContainer
   {
       
      
      public var tf_points:ClipLabel;
      
      public var tf_rewards:ClipLabel;
      
      public function TitanArenaPointsRewardsTitlesClip()
      {
         tf_points = new ClipLabel();
         tf_rewards = new ClipLabel();
         super();
      }
      
      public function setTitles(param1:String, param2:String) : void
      {
         this.tf_points.text = param1;
         this.tf_rewards.text = param2;
         this.tf_points.validate();
         this.tf_rewards.validate();
      }
   }
}
