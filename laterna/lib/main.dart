import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class AppCores {
  static const fundo = Color(0xFF08090C);
  static const painel = Color(0xFF12141A);
  static const painelClaro = Color(0xFF1A1D24);
  static const amarelo = Color(0xFFFFD54F);
  static const amareloForte = Color(0xFFFFB800);
  static const branco = Color(0xFFF5F5F5);
  static const cinza = Color(0xFF969AA5);
  static const verde = Color(0xFF65D391);
  static const roxo = Color(0xFF9C7BFF);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lanterna Inteligente',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppCores.fundo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppCores.amarelo,
          brightness: Brightness.dark,
        ),
      ),
      home: const LanternaScreen(),
    );
  }
}

class LanternaScreen extends StatefulWidget {
  const LanternaScreen({super.key});

  @override
  State<LanternaScreen> createState() => _LanternaScreenState();
}

class _LanternaScreenState extends State<LanternaScreen> {
  bool _lanternaLigada = false;
  bool _modoAutomatico = false;

  void _alternarLanterna() {
    setState(() {
      _lanternaLigada = !_lanternaLigada;
    });
  }

  void _alternarModoAutomatico(bool valor) {
    setState(() {
      _modoAutomatico = valor;
      // Ao ativar o automático, a lanterna fica pronta/ligada.
      if (valor) _lanternaLigada = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            children: [
              _cabecalho(),
              const SizedBox(height: 22),
              _painelLanterna(),
              const SizedBox(height: 14),
              _modoAutomaticoCard(),
              const SizedBox(height: 14),
              _indicadores(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cabecalho() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppCores.amarelo.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppCores.amarelo.withValues(alpha: .25),
            ),
          ),
          child: const Icon(
            Icons.flashlight_on_rounded,
            color: AppCores.amarelo,
            size: 26,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lanterna',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: AppCores.branco,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'INTELIGENTE',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: AppCores.cinza,
                ),
              ),
            ],
          ),
        ),
        _status(),
      ],
    );
  }

  Widget _status() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _lanternaLigada
            ? AppCores.amarelo.withValues(alpha: .11)
            : Colors.white.withValues(alpha: .04),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: _lanternaLigada
              ? AppCores.amarelo.withValues(alpha: .35)
              : Colors.white.withValues(alpha: .08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: _lanternaLigada ? AppCores.amarelo : Colors.grey,
              shape: BoxShape.circle,
              boxShadow: _lanternaLigada
                  ? [
                      BoxShadow(
                        color: AppCores.amarelo.withValues(alpha: .7),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            _lanternaLigada ? 'ATIVA' : 'OFF',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: _lanternaLigada
                  ? AppCores.amarelo
                  : AppCores.cinza,
            ),
          ),
        ],
      ),
    );
  }

  Widget _painelLanterna() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: AppCores.painel,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: _lanternaLigada
              ? AppCores.amarelo.withValues(alpha: .22)
              : Colors.white.withValues(alpha: .06),
        ),
        boxShadow: _lanternaLigada
            ? [
                BoxShadow(
                  color: AppCores.amarelo.withValues(alpha: .07),
                  blurRadius: 35,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'STATUS DA LANTERNA',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                  color: AppCores.cinza,
                ),
              ),
              Icon(
                _lanternaLigada
                    ? Icons.wb_sunny_rounded
                    : Icons.nightlight_round,
                size: 19,
                color: _lanternaLigada
                    ? AppCores.amarelo
                    : AppCores.cinza,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _luzCentral(),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              _lanternaLigada
                  ? 'Iluminando seu caminho'
                  : 'A lanterna está desligada',
              key: ValueKey(_lanternaLigada),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppCores.branco,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _modoAutomatico
                ? 'Modo automático ativado'
                : 'Toque no botão para controlar a luz',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppCores.cinza,
            ),
          ),
          const SizedBox(height: 22),
          _botaoPrincipal(),
        ],
      ),
    );
  }

  Widget _luzCentral() {
    return SizedBox(
      width: 235,
      height: 235,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _lanternaLigada ? 210 : 165,
            height: _lanternaLigada ? 210 : 165,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _lanternaLigada
                  ? AppCores.amarelo.withValues(alpha: .035)
                  : Colors.transparent,
              boxShadow: _lanternaLigada
                  ? [
                      BoxShadow(
                        color: AppCores.amarelo.withValues(alpha: .16),
                        blurRadius: 55,
                        spreadRadius: 14,
                      ),
                    ]
                  : null,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            width: _lanternaLigada ? 150 : 120,
            height: _lanternaLigada ? 150 : 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: _lanternaLigada
                  ? const RadialGradient(
                      colors: [
                        Color(0xFFFFF7B8),
                        AppCores.amarelo,
                        AppCores.amareloForte,
                      ],
                    )
                  : null,
              color: _lanternaLigada ? null : AppCores.painelClaro,
              border: Border.all(
                width: 2,
                color: _lanternaLigada
                    ? AppCores.amarelo
                    : Colors.white.withValues(alpha: .08),
              ),
              boxShadow: _lanternaLigada
                  ? [
                      BoxShadow(
                        color: AppCores.amarelo.withValues(alpha: .4),
                        blurRadius: 30,
                        spreadRadius: 3,
                      ),
                    ]
                  : null,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _lanternaLigada
                    ? Icons.flashlight_on_rounded
                    : Icons.flashlight_off_rounded,
                key: ValueKey(_lanternaLigada),
                size: _lanternaLigada ? 66 : 54,
                color: _lanternaLigada
                    ? Colors.black87
                    : Colors.white24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoPrincipal() {
    return Semantics(
      button: true,
      label: _lanternaLigada
          ? 'Desligar lanterna'
          : 'Ligar lanterna',
      child: GestureDetector(
        onTap: _alternarLanterna,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            color: _lanternaLigada
                ? AppCores.amarelo
                : AppCores.painelClaro,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _lanternaLigada
                  ? AppCores.amarelo
                  : Colors.white.withValues(alpha: .08),
            ),
            boxShadow: _lanternaLigada
                ? [
                    BoxShadow(
                      color: AppCores.amarelo.withValues(alpha: .16),
                      blurRadius: 18,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _lanternaLigada
                    ? Icons.power_settings_new_rounded
                    : Icons.flashlight_on_rounded,
                color: _lanternaLigada
                    ? Colors.black
                    : AppCores.amarelo,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                _lanternaLigada
                    ? 'DESLIGAR LANTERNA'
                    : 'LIGAR LANTERNA',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: _lanternaLigada
                      ? Colors.black
                      : AppCores.branco,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modoAutomaticoCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _modoAutomatico
            ? AppCores.roxo.withValues(alpha: .10)
            : AppCores.painel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _modoAutomatico
              ? AppCores.roxo.withValues(alpha: .35)
              : Colors.white.withValues(alpha: .06),
        ),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _modoAutomatico
                  ? AppCores.roxo.withValues(alpha: .18)
                  : AppCores.painelClaro,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 23,
              color: _modoAutomatico
                  ? AppCores.roxo
                  : AppCores.cinza,
            ),
          ),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modo Automático',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppCores.branco,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Controle inteligente da iluminação',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppCores.cinza,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _modoAutomatico,
            onChanged: _alternarModoAutomatico,
            activeColor: Colors.white,
            activeTrackColor: AppCores.roxo,
          ),
        ],
      ),
    );
  }

  Widget _indicadores() {
    return Row(
      children: [
        Expanded(
          child: _infoCard(
            Icons.bolt_rounded,
            'ENERGIA',
            _lanternaLigada ? 'ATIVA' : 'ECONÔMICA',
            AppCores.amarelo,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _infoCard(
            Icons.shield_outlined,
            'SISTEMA',
            'PRONTO',
            AppCores.verde,
          ),
        ),
      ],
    );
  }

  Widget _infoCard(
    IconData icon,
    String titulo,
    String valor,
    Color cor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppCores.painel,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: Colors.white.withValues(alpha: .06),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: cor.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cor, size: 19),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: AppCores.cinza,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppCores.branco,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
