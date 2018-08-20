package game.data.storage.tower
{
   public class TowerBuffEffect
   {
      
      public static const STATE_HP:String = "hp";
      
      public static const STATE_ENERGY:String = "energy";
      
      public static const STATE_RESURRECTION:String = "resurrection";
       
      
      public var value:Number;
      
      public var effect:String;
      
      public var isStateEffect:Boolean;
      
      public function TowerBuffEffect(param1:*)
      {
         super();
         this.value = param1.value;
         this.effect = param1.effect;
         this.isStateEffect = param1.isStateEffect;
      }
   }
}
