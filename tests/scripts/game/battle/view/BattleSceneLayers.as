package game.battle.view
{
   import starling.display.Sprite;
   
   public class BattleSceneLayers
   {
      
      public static var statusLayerAlpha:Number = 1;
       
      
      public const background:Sprite = new Sprite();
      
      public const statusContainer:Sprite = new Sprite();
      
      public const foreground:Sprite = new Sprite();
      
      public function BattleSceneLayers()
      {
         super();
         statusContainer.alpha = statusLayerAlpha;
      }
   }
}
