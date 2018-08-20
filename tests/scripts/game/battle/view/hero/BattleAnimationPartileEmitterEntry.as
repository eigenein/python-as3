package game.battle.view.hero
{
   import com.progrestar.framework.ares.core.Clip;
   
   public class BattleAnimationPartileEmitterEntry
   {
       
      
      public var z:Number;
      
      public var clip:Clip;
      
      public var needMarker:Boolean;
      
      public var length:int;
      
      public var currentTime:Number;
      
      public var currentFrame:int;
      
      public function BattleAnimationPartileEmitterEntry(param1:Clip, param2:Number, param3:Boolean)
      {
         super();
         this.clip = param1;
         this.z = param2;
         this.needMarker = param3;
         length = param1.timeLine.length;
         currentTime = 0;
         currentFrame = 0;
      }
   }
}
