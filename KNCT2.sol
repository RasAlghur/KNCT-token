// SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";

interface ISwapFactory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

interface ISwapPair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

interface ISwapRouter01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface ISwapRouter02 is ISwapRouter01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;
    address private _previousOwner;
    uint256 private _lockTime;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract KNTC is IERC20, Ownable, ERC20Permit, ERC20Votes {
    uint256 private constant MAX_UINT256 = ~uint256(0);
    uint256 private constant INITIAL_FRAGMENTS_SUPPLY = 10 * 10**5 * 10**DECIMALS;

    uint256 private constant BP_DIVISOR = 10000;

    uint256 private numTokensSwap;
    uint256 private _maxTxAmount;
    uint256 private maxWalletAmount;

    address private constant BURN_ADDRESS = 0x000000000000000000000000000000000000dEaD;

    string private constant NAME = "KNTCKY";
    string private constant SYMBOL = "KNTC2";
    uint8 private constant DECIMALS = 9;

    // marketingTax is 3% i.e (300 / 100)%
    uint256 public marketingTax = 300;

    uint256 private transactionTax = marketingTax;

    ISwapRouter02 public swapRouter;
    address public swapPair;
    address public marketingWallet = 0x1Fd5874de36562608D0A0aD8dA51688DFA943605;

    bool private inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = true;

    mapping(address => bool) private _isExcluded;
    mapping(address => bool) private _isMaxTxExcluded;
    uint256 public launchTime;

    uint256 private constant TOTAL_WCD =
        MAX_UINT256 - (MAX_UINT256 % INITIAL_FRAGMENTS_SUPPLY);

    uint256 private constant MAX_SUPPLY = ~uint128(0);

    uint256 private _totalSupply;
    uint256 private _wcdPerFragment;
    mapping(address => uint256) private _twcdBalances;

    mapping(address => mapping(address => uint256)) private _allowedFragments;

    event LogRebase(uint256 indexed epoch, uint256 totalSupply);
    event OwnerForceSwapback(uint256 timestamp);

    modifier lockTheSwap() {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }

    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        ISwapRouter02 _swapRouter = ISwapRouter02(
            0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        );
        swapPair = ISwapFactory(_swapRouter.factory()).createPair(
            address(this),
            _swapRouter.WETH()
        );
        swapRouter = _swapRouter;

        _totalSupply = INITIAL_FRAGMENTS_SUPPLY;
        _twcdBalances[owner()] = TOTAL_WCD;
        _wcdPerFragment = TOTAL_WCD / _totalSupply;

        // ddd cds
        numTokensSwap = (_totalSupply * 1) / 1000;
        _maxTxAmount = (_totalSupply * 1) / 100;
        maxWalletAmount = ((_totalSupply * 3) / 100) * _wcdPerFragment;

        _isExcluded[owner()] = true;
        _isExcluded[address(this)] = true;

        emit Transfer(address(0), owner(), _totalSupply);
    }

    receive() external payable {}

     function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._afterTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._burn(account, amount);
    }

    function _negativeRebase(uint256 epoch, int256 supplyDelta)
        external
        onlyOwner
        returns (uint256)
    {
        if (supplyDelta == 0) {
            emit LogRebase(epoch, _totalSupply);
            return _totalSupply;
        }

        if (supplyDelta < 0) {
            _totalSupply -= (uint256(-supplyDelta) * 10**DECIMALS);
        } 

        uint256 initialBurnBal = balanceOf(BURN_ADDRESS);
        uint256 initialPoolBal = balanceOf(swapPair);
        _wcdPerFragment = (TOTAL_WCD) / _totalSupply;
        uint256 afterBurnBal = balanceOf(BURN_ADDRESS);
        uint256 afterPoolBal = balanceOf(swapPair);
        uint256 newBurnBal = initialBurnBal - afterBurnBal;
        uint256 newPoolBal = initialPoolBal - afterPoolBal;
        _twcdBalances[BURN_ADDRESS] += newBurnBal * _wcdPerFragment;
        _twcdBalances[swapPair] += newPoolBal * _wcdPerFragment;
        ISwapPair(swapPair).sync();

        emit LogRebase(epoch, _totalSupply);
        return _totalSupply;
    }

    function _positiveRebase(uint256 epoch, int256 supplyDelta)
        external
        onlyOwner
        returns (uint256)
    {
        if (supplyDelta == 0) {
            emit LogRebase(epoch, _totalSupply);
            return _totalSupply;
        }

        if (supplyDelta > 0) {
            _totalSupply += (uint256(supplyDelta) * 10**DECIMALS) - balanceOf(BURN_ADDRESS);
        }

        uint256 initialBurnBal = balanceOf(BURN_ADDRESS);
        uint256 initialPoolBal = balanceOf(swapPair);
        _wcdPerFragment = (TOTAL_WCD) / _totalSupply;
        uint256 afterBurnBal = balanceOf(BURN_ADDRESS);
        uint256 afterPoolBal = balanceOf(swapPair);
        uint256 newBurnBal = afterBurnBal - initialBurnBal;
        uint256 newPoolBal = afterPoolBal - initialPoolBal;
        _twcdBalances[BURN_ADDRESS] -= newBurnBal * _wcdPerFragment;
        _twcdBalances[swapPair] -= newPoolBal * _wcdPerFragment;
        ISwapPair(swapPair).sync();

        emit LogRebase(epoch, _totalSupply);
        return _totalSupply;
    }

    function totalSupply() public view override(IERC20, ERC20) returns (uint256) {
        return _totalSupply;
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        (IERC20, ERC20)
        returns (bool)
    {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override(IERC20, ERC20) returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            msg.sender,
            _allowedFragments[sender][msg.sender] - amount
        );
        return true;
    }

    function name() public view virtual override returns (string memory) {
        return NAME;
    }

    function symbol() public view virtual override returns (string memory) {
        return SYMBOL;
    }

    function decimals() public view virtual override returns (uint8) {
        return DECIMALS;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        virtual
        override
        returns (bool)
    {
        _approve(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender] + addedValue
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        virtual
        override
        returns (bool)
    {
        require(
            subtractedValue <= _allowedFragments[msg.sender][spender],
            "Allowance not high enough"
        );
        _approve(
            msg.sender,
            spender,
            _allowedFragments[msg.sender][spender] - subtractedValue
        );
        return true;
    }

    function approve(address spender, uint256 amount)
        public
        override
        (IERC20, ERC20)
        returns (bool)
    {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner_, address spender)
        public
        view
        override
        (IERC20, ERC20)
        returns (uint256)
    {
        return _allowedFragments[owner_][spender];
    }

    function setSwapAndLiquifyEnabled(bool _enabled) public onlyOwner {
        swapAndLiquifyEnabled = _enabled;
    }

    function balanceOf(address account) public view override(IERC20, ERC20) returns (uint256) {
        return _twcdBalances[account] / _wcdPerFragment;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual override {
        require(
            owner != address(0),
            "Cannot approve from the zero address"
        );
        require(spender != address(0), "Cannot approve the zero address");

        _allowedFragments[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual override {
        require(
            recipient != address(0),
            "Cannot transfer to the zero address"
        );
        require(amount > 0, "Cannot transfer zero tokens");
        require(
            launchTime != 0 || _isExcluded[sender] || _isExcluded[recipient],
            "Not yet launched"
        );

        if (!_isExcluded[sender] && !_isExcluded[recipient])
            require(
                amount <= _maxTxAmount,
                "Transfer amount exceeds the maxTxAmount."
            );

        uint256 contractTokenBalance = balanceOf(address(this));
        if (
            contractTokenBalance >= numTokensSwap &&
            !inSwapAndLiquify &&
            swapAndLiquifyEnabled &&
            sender != swapPair &&
            !_isExcluded[sender] &&
            !_isExcluded[recipient]
        ) swapAndLiquify(numTokensSwap);

        _tokenTransfer(sender, recipient, amount);
    }

    function _tokenTransfer(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        if (
            _twcdBalances[sender] - (amount * _wcdPerFragment) == 0 &&
            !_isExcluded[sender]
        ) amount -= 1;

        uint256 transferAmount = amount * _wcdPerFragment;
        uint256 receiveAmount = transferAmount;
        uint256 fee;

        if (
            !_isExcluded[recipient] &&
            sender != owner() &&
            recipient != swapPair
        )
            require(
                _twcdBalances[recipient] + receiveAmount <= maxWalletAmount,
                "Can't hold that much"
            );

        if (!_isExcluded[sender] && !_isExcluded[recipient]) {
            uint256 fairness = (launchTime > 0 &&
                block.timestamp < launchTime + 5)
                ? transactionTax + 100
                : BP_DIVISOR;
            fee = (amount * transactionTax) / fairness;
            receiveAmount -= (fee * _wcdPerFragment);
        }

        _twcdBalances[sender] -= transferAmount;
        _twcdBalances[recipient] += receiveAmount;

        if (fee > 0) {
            _twcdBalances[address(this)] += (fee * _wcdPerFragment);
            emit Transfer(sender, address(this), fee);
        }

        emit Transfer(sender, recipient, amount - fee);
    }

    function swapAndLiquify(uint256 contractTokenBalance) private lockTheSwap {
        uint256 tokensToETH = contractTokenBalance;
        swapTokensForEth(tokensToETH);
        uint256 marketingETH = address(this).balance;

        if (marketingETH > 0) {
            payable(marketingWallet).transfer(marketingETH);
        }
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = swapRouter.WETH();

        _approve(address(this), address(swapRouter), tokenAmount);

        swapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount)
        private
        returns (uint256)
    {
        _approve(address(this), address(swapRouter), tokenAmount);

        // add the liquidity
        (, uint256 amountEthFromLiquidity, ) = swapRouter.addLiquidityETH{
            value: ethAmount
        }(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(this),
            block.timestamp
        );

        return (ethAmount - amountEthFromLiquidity);
    }

    function excludeAddressFromFees(address account) external onlyOwner {
        _isExcluded[account] = true;
    }

    function excludeFromMaxTxLimit(address account) external onlyOwner {
        _isMaxTxExcluded[account] = true;
    }

    function updNumTokensSwap(uint256 point, uint256 percent)
        external
        onlyOwner
    {
        uint256 check = (_totalSupply * point) / percent;
        require(
            check < (_totalSupply * 1) / 100,
            "numTokenSwap can not be above 1%"
        );
        numTokensSwap = check;
    }

    function setFee(uint256 _marketingFee) external onlyOwner {
        uint256 totalFee = _marketingFee;
        require(totalFee < 1000, "Total fee must be < 10%");
        marketingTax = _marketingFee * 100;
        transactionTax = totalFee;
    }

    function setMarketingWallet(address payable wallet) external onlyOwner {
        require(
            marketingWallet != address(0),
            "marketing wallet cannot zero address"
        );
        marketingWallet = wallet;
    }

    function updateMaxTx(uint256 unit, uint256 percent) external onlyOwner {
        uint256 check = (_totalSupply * unit) / percent;
        require(check > (_totalSupply * 5) / 1000, "Max tx must be > 0.5%");
        _maxTxAmount = check;
    }

    function updateMaxWallet(uint256 unit, uint256 percent) external onlyOwner {
        uint256 check = ((_totalSupply * unit) / percent) * _wcdPerFragment;
        require(
            check > ((_totalSupply * 1) / 100) * _wcdPerFragment,
            "Max Walet must be > 1%"
        );
        maxWalletAmount = check;
    }

    function launch() external onlyOwner {
        launchTime = block.timestamp;
    }

    function forceSwapBack() external onlyOwner {
        uint256 contractTokenBalance = balanceOf(address(this));
        require(
            contractTokenBalance >= (_totalSupply * 1) / 1000,
            "Contract Balance Should be Higher than 0.2%"
        );
        swapAndLiquify(numTokensSwap);
        emit OwnerForceSwapback(block.timestamp);
    }

    function withdrawWETH(address _account) external onlyOwner {
        require(
            _account != address(0),
            "Can't withdraw to the zero address"
        );

        uint256 contractBalance = address(this).balance;

        if (contractBalance > 0) payable(_account).transfer(contractBalance);
    }

    function withdrawToken(address _token, address _account)
        external
        onlyOwner
    {
        require(_token != address(0), "Can't withdraw a token of zero address");
        require(_token != address(this), "Can't withdraw KNTC tokens");
        require(_account != address(0), "Can't withdraw to the zero address");

        uint256 tokenBalance = IERC20(_token).balanceOf(address(this));

        if (tokenBalance > 0) IERC20(_token).transfer(_account, tokenBalance);
    }
}
