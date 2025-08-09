import 'dart:async';
import 'package:flutter/material.dart';
import 'package:manager/src/core/services/real_time/update_queus_realtime_service.dart';
import 'package:paipfood_package/paipfood_package.dart';

class RealtimeStatusWidget extends StatefulWidget {
  final UpdateQueusRealtimeService realtimeService;

  const RealtimeStatusWidget({
    required this.realtimeService,
    super.key,
  });

  @override
  State<RealtimeStatusWidget> createState() => _RealtimeStatusWidgetState();
}

class _RealtimeStatusWidgetState extends State<RealtimeStatusWidget> {
  late Timer _updateTimer;

  @override
  void initState() {
    super.initState();
    // Atualiza o status a cada 2 segundos
    _updateTimer = Timer.periodic(2.seconds, (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = widget.realtimeService.isConnected;
    final hasNetwork = widget.realtimeService.hasNetworkConnection;
    final reconnectAttempts = widget.realtimeService.reconnectAttempts;

    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (isConnected && hasNetwork) {
      statusColor = Colors.green;
      statusIcon = Icons.wifi;
      statusText = 'Conectado';
    } else if (hasNetwork && !isConnected) {
      statusColor = Colors.orange;
      statusIcon = Icons.sync;
      statusText = reconnectAttempts > 0 ? 'Reconectando...' : 'Conectando...';
    } else {
      statusColor = Colors.red;
      statusIcon = Icons.wifi_off;
      statusText = 'Sem Internet';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border.all(color: statusColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 16,
            color: statusColor,
          ),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          if (reconnectAttempts > 0 && !isConnected) ...[
            const SizedBox(width: 6),
            Text(
              '($reconnectAttempts)',
              style: TextStyle(
                color: statusColor.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Widget compacto para a barra superior
class RealtimeStatusIndicator extends StatefulWidget {
  final UpdateQueusRealtimeService realtimeService;

  const RealtimeStatusIndicator({
    required this.realtimeService,
    super.key,
  });

  @override
  State<RealtimeStatusIndicator> createState() => _RealtimeStatusIndicatorState();
}

class _RealtimeStatusIndicatorState extends State<RealtimeStatusIndicator> with SingleTickerProviderStateMixin {
  late Timer _updateTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _updateTimer = Timer.periodic(2.seconds, (timer) {
      if (mounted) setState(() {});
    });

    // Inicia animação de pulse se não conectado
    _updatePulseAnimation();
  }

  void _updatePulseAnimation() {
    if (widget.realtimeService.isConnected) {
      _pulseController.stop();
    } else {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = widget.realtimeService.isConnected;
    final hasNetwork = widget.realtimeService.hasNetworkConnection;

    _updatePulseAnimation();

    Color dotColor;
    if (isConnected && hasNetwork) {
      dotColor = Colors.green;
    } else if (hasNetwork && !isConnected) {
      dotColor = Colors.orange;
    } else {
      dotColor = Colors.red;
    }

    return GestureDetector(
      onTap: () {
        // Mostra dialog com detalhes do status
        _showStatusDialog(context);
      },
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: dotColor.withOpacity(isConnected ? 1.0 : _pulseAnimation.value),
              shape: BoxShape.circle,
              boxShadow: [
                if (!isConnected)
                  BoxShadow(
                    color: dotColor.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: _pulseAnimation.value * 2,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showStatusDialog(BuildContext context) {
    final service = widget.realtimeService;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              service.isConnected ? Icons.check_circle : Icons.warning,
              color: service.isConnected ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 8),
            const Text('Status Real-Time'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusRow(
              label: 'Conexão Real-Time:',
              value: service.isConnected ? 'Conectado' : 'Desconectado',
              color: service.isConnected ? Colors.green : Colors.red,
            ),
            _StatusRow(
              label: 'Internet:',
              value: service.hasNetworkConnection ? 'Disponível' : 'Indisponível',
              color: service.hasNetworkConnection ? Colors.green : Colors.red,
            ),
            if (service.reconnectAttempts > 0)
              _StatusRow(
                label: 'Tentativas de Reconexão:',
                value: '${service.reconnectAttempts}',
                color: Colors.orange,
              ),
            const SizedBox(height: 16),
            Text(
              service.isConnected ? '✅ Sistema funcionando normalmente!\nTodos os pedidos serão recebidos em tempo real.' : '⚠️ Sistema tentando reconectar...\nPedidos podem ter atraso na chegada.',
              style: TextStyle(
                fontSize: 14,
                color: service.isConnected ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
          if (!service.isConnected)
            ElevatedButton(
              onPressed: () {
                service.verifyReconnect();
                Navigator.of(context).pop();
              },
              child: const Text('Tentar Reconectar'),
            ),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatusRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
