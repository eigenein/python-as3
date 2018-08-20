package battle.proxy
{
   public interface IBattleBodyProxy
   {
       
      
      function setYSpeed(param1:Number, param2:Number, param3:Number = undefined, param4:Number = undefined) : void;
      
      function setYPosition(param1:Number) : void;
      
      function getViewPosition() : ViewPosition;
   }
}
